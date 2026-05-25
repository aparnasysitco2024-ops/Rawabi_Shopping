import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/notification/notificationData.dart';

import '../controller/notificationListController.dart';
import '../model/response/languageParamResponse.dart';
import '../utils/colors.dart';
import '../utils/notification/notification_storage_service.dart';
import '../utils/storage_manager.dart';
import '../widget/commonWidget/reusable_text.dart';
import 'deliverymode/deliveryModeScreen.dart';
import 'navigator/bottomNavBar.dart';
import 'package:path_provider/path_provider.dart';

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotification(NotificationResponse details) {
  if (details.payload != null) {
    _handleNotificationClick(details.payload!);
  }
}

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  String? productId;
  SplashScreen({super.key, this.productId = ""});

  var languageParam = LanguageParam().obs;
  var languageParamString = "";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _firebaseInitialized = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // ─── Internet check ───────────────────────────────────────────────────

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Shows a styled "No Internet" alert.
  /// Returns true when the user taps "Retry" and connectivity is restored.
  Future<void> _showNoInternetDialog() async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _NoInternetDialog(
        onRetry: () async {
          Navigator.of(ctx).pop(); // close dialog first
          final connected = await _hasInternetAccess();
          if (connected) {
            // Re-run the full init flow
            await initialize();
          } else {
            // Show again if still offline
            await _showNoInternetDialog();
          }
        },
      ),
    );
  }

  // ─── Init flow ────────────────────────────────────────────────────────

  Future<void> initialize() async {
    // Check internet before doing anything
    final connected = await _hasInternetAccess();
    if (!connected) {
      await _showNoInternetDialog();
      return; // dialog handles retry → re-calls initialize()
    }

    var prefValue =
    await StorageManager.readData(StorageManager.sharedPrfValue);
    if (prefValue != "2") {
      StorageManager.clearData();
      StorageManager.saveData(StorageManager.sharedPrfValue, "2");
    }

    if (!await StorageManager.readDataBool(StorageManager.keyIsLogin)) {
      StorageManager.saveData(StorageManager.keyUserID, "0");
    }

    await _requestLocationAndProceed();
  }

  Future<void> _requestLocationAndProceed() async {
    final status = await Permission.location.request();
    print('Location permission status: $status');
    await firebase();
  }

  moveToPage() {
    Timer(const Duration(seconds: 1), () async {
      String storeAddress =
      await StorageManager.readData(StorageManager.keyStoreAddress);
      if (storeAddress.isEmpty) {
        AppUtils.navigateToPage(DeliveryModeScreen());
      } else {
        AppUtils.navigateToPageReplace(
            BottomNavBar(productId: widget.productId));
      }
    });
  }

  Future<void> getLanguageData() async {
    widget.languageParamString =
    await StorageManager.readData(StorageManager.keyLanguageParams);
    if (widget.languageParamString.isNotEmpty) {
      moveToPage();
    } else {
      await readJsonLanguage();
    }
  }

  Future<void> readJsonLanguage() async {
    final String response =
    await rootBundle.loadString('assets/json/englishLanguage.json');
    widget.languageParam.value = LanguageParam.fromJson(json.decode(response));
    StorageManager.saveData(StorageManager.keyLanguageParams,
        json.encode(widget.languageParam.value));
    moveToPage();
  }

  Future<void> firebase() async {
    if (_firebaseInitialized) return;
    _firebaseInitialized = true;

    try {
      final messaging = FirebaseMessaging.instance;

      await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (Platform.isIOS) {
        String? apnsToken;
        int retries = 0;
        while (apnsToken == null && retries < 5) {
          apnsToken = await messaging.getAPNSToken();
          if (apnsToken == null) {
            retries++;
            print('APNs token not ready, retrying... attempt $retries');
            await Future.delayed(const Duration(seconds: 2));
          }
        }
        if (apnsToken == null) {
          print('Could not get APNs token, skipping FCM setup');
          await getLanguageData();
          return;
        }
        print('APNs token ready: $apnsToken');
      }

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
      );

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      final savedToken =
      await StorageManager.readData(StorageManager.keyFirebaseToken);

      if (savedToken == "") {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null) {
          await StorageManager.saveData(
              StorageManager.keyFirebaseToken, fcmToken);
          await FirebaseMessaging.instance.subscribeToTopic("all");
          print("FCM Token: $fcmToken");
          unawaited(
            Future.delayed(const Duration(seconds: 1), () async {
              await subscribeToTopicWithRetry(topic: 'rawabi_user');
            }),
          );
        }
      }

      var initSettings = InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: const DarwinInitializationSettings(),
      );

      await flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotification,
        onDidReceiveNotificationResponse: onDidReceiveBackgroundNotification,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        final notification = message.notification;

        if (notification != null) {
          await NotificationStorageService.saveNotification(
            title: notification.title ?? '',
            body: notification.body ?? '',
            data: message.data,
          );
          if (Get.isRegistered<NotificationListController>()) {
            Get.find<NotificationListController>().onNewNotification();
          }
        }

        if (notification == null && message.data.isNotEmpty) {
          final title =
              message.data['title'] ?? message.data['Title'] ?? 'New Notification';
          final body = message.data['body'] ?? message.data['Body'] ?? '';
          await NotificationStorageService.saveNotification(
            title: title.toString(),
            body: body.toString(),
            data: message.data,
          );
          if (Get.isRegistered<NotificationListController>()) {
            Get.find<NotificationListController>().onNewNotification();
          }
        }

        if (notification != null) {
          String? imageUrl;
          if (Platform.isIOS) {
            imageUrl = message.notification?.apple?.imageUrl;
          } else {
            imageUrl = message.notification?.android?.imageUrl;
            imageUrl ??= message.data['image']?.toString();
          }

          String? localImagePath;
          if (imageUrl != null && imageUrl.isNotEmpty) {
            localImagePath = await _downloadAndSaveImage(imageUrl);
          }

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            payload: jsonEncode(message.data),
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                importance: Importance.high,
                priority: Priority.high,
                icon: '@drawable/launcher_icon',
                color: const Color(0xFFFFEB3B),
                playSound: true,
                styleInformation: localImagePath != null
                    ? BigPictureStyleInformation(
                  FilePathAndroidBitmap(localImagePath),
                  hideExpandedLargeIcon: false,
                )
                    : const DefaultStyleInformation(true, true),
              ),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                attachments: localImagePath != null
                    ? [DarwinNotificationAttachment(localImagePath)]
                    : null,
              ),
            ),
          );
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (context.mounted) {
          _handleNotificationClick1(context, message);
        }
      });

      final initialMessage =
      await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null && context.mounted) {
        _handleNotificationClick1(context, initialMessage);
      }

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      await getLanguageData();
    } catch (e) {
      print("-------------------firebase error-------------------");
      print(e);
      await getLanguageData();
    }
  }

  Future<bool> subscribeToTopicWithRetry({
    required String topic,
    int maxRetries = 5,
    Duration initialDelay = const Duration(seconds: 2),
  }) async {
    for (int attempt = 1; attempt <= maxRetries; attempt++) {
      try {
        print('Attempt $attempt: Subscribing to topic: $topic');
        await FirebaseMessaging.instance
            .subscribeToTopic(topic)
            .timeout(const Duration(seconds: 10));
        print('Successfully subscribed to topic: $topic');
        return true;
      } catch (e) {
        print('Attempt $attempt failed for topic $topic: $e');
        if (attempt == maxRetries) return false;
        final delay = initialDelay * (1 << (attempt - 1));
        print('Retrying in ${delay.inSeconds} seconds...');
        await Future.delayed(delay);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Platform.isAndroid
                ? "assets/images/splash.png"
                : "assets/images/splash_iphone.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset("assets/icons/logo.svg", height: 80),
              const SizedBox(height: 10),
              ReusableText(
                textAlign: TextAlign.center,
                title: "Get your groceries delivered to your home".tr,
                size: 19,
                color: blackLight,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 10),
              ReusableText(
                textAlign: TextAlign.center,
                title:
                "The best delivery app in town for delivering your daily fresh groceries"
                    .tr,
                size: 15,
                color: grey,
                weight: FontWeight.w400,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── No Internet Dialog Widget ────────────────────────────────────────────────

class _NoInternetDialog extends StatefulWidget {
  final Future<void> Function() onRetry;

  const _NoInternetDialog({required this.onRetry});

  @override
  State<_NoInternetDialog> createState() => _NoInternetDialogState();
}

class _NoInternetDialogState extends State<_NoInternetDialog> {
  bool _isRetrying = false;

  Future<void> _handleRetry() async {
    setState(() => _isRetrying = true);
    await widget.onRetry();
    // If dialog is still mounted after retry (still offline), reset state
    if (mounted) setState(() => _isRetrying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 38,
                color: Color(0xFFFF6F00),
              ),
            ),
            const SizedBox(height: 20),

            // Title
            const Text(
              'No Internet Connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1A1A2E),
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 10),

            // Body
            const Text(
              'Please check your Wi-Fi or mobile data and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF757575),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),

            // Retry Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isRetrying ? null : _handleRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFEB3B),
                  foregroundColor: const Color(0xFF1A1A2E),
                  disabledBackgroundColor: const Color(0xFFFFF9C4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isRetrying
                    ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF1A1A2E),
                    ),
                  ),
                )
                    : const Text(
                  'Try Again',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Top-level functions (outside any class) ──────────────────────────────────

Future<String?> _downloadAndSaveImage(String imageUrl) async {
  try {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/notif_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    }
  } catch (e) {
    print('Image download failed: $e');
  }
  return null;
}

void _handleNotificationClick(String payload) {
  try {
    final responseData = NotificationData.fromJson(json.decode(payload));
    if (responseData.type == "product") {
      Navigator.pushNamed(
        Get.context!,
        '/ProductDetailsScreen',
        arguments: {'productID': responseData.id.toString()},
      );
    } else if (responseData.type == "itemgroup") {
      Navigator.pushNamed(
        Get.context!,
        '/ProductsFromHomeScreen',
        arguments: {'title': "", "grp_id": responseData.id.toString()},
      );
    }
  } catch (e) {
    print('Error handling notification click: $e');
  }
}

void _handleNotificationClick1(BuildContext context, RemoteMessage message) {
  final notificationData = message.data;
  Timer(const Duration(seconds: 1), () {
    if (!notificationData.containsKey('type')) return;
    final type = notificationData['type'];
    final id = notificationData['id'];
    if (type == "product") {
      Navigator.pushNamed(
        context,
        '/ProductDetailsScreen',
        arguments: {'productID': id.toString()},
      );
    } else if (type == "itemgroup") {
      Navigator.pushNamed(
        context,
        '/ProductsFromHomeScreen',
        arguments: {'title': "", "grp_id": id.toString()},
      );
    }
  });
}