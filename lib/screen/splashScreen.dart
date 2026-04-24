import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/notification/notificationData.dart';

import '../model/response/languageParamResponse.dart';
import '../utils/colors.dart';
import '../utils/storage_manager.dart';
import '../widget/commonWidget/reusable_text.dart';
import 'deliverymode/deliveryModeScreen.dart';
import 'navigator/bottomNavBar.dart';

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

  bool _firebaseInitialized = false; // ✅ guard flag

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    var prefValue = await StorageManager.readData(StorageManager.sharedPrfValue);
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
    // ✅ Request permission once, then call firebase() exactly once
    final status = await Permission.location.request();
    print('Location permission status: $status');
    await firebase(); // always called exactly once, regardless of status
  }

  moveToPage() {
    Timer(const Duration(seconds: 1), () async {
      String storeAddress =
      await StorageManager.readData(StorageManager.keyStoreAddress);
      if (storeAddress.isEmpty) {
        AppUtils.navigateToPage(DeliveryModeScreen());
      } else {
        AppUtils.navigateToPageReplace(BottomNavBar(productId: widget.productId));
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
    StorageManager.saveData(
        StorageManager.keyLanguageParams,
        json.encode(widget.languageParam.value));
    moveToPage();
  }

  Future<void> firebase() async {
    // ✅ Guard against being called more than once
    if (_firebaseInitialized) return;
    _firebaseInitialized = true;

    try {
      // ✅ DO NOT call Firebase.initializeApp() here — already done in main.dart

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

      // ✅ iOS APNs token wait
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
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
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

      // ✅ Top-level function references — fixes the assertion crash
      var initSettings = InitializationSettings(
        android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: const DarwinInitializationSettings(),
      );

      await flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveBackgroundNotificationResponse:
        onDidReceiveBackgroundNotification, // ✅ top-level
        onDidReceiveNotificationResponse:
        onDidReceiveBackgroundNotification,   // ✅ top-level
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final notification = message.notification;
        final android = message.notification?.android;
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            payload: jsonEncode(message.data),
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                icon: '@drawable/launcher_icon',
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
      await getLanguageData(); // ✅ always navigate even on error
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
                "The best delivery app in town for delivering your daily fresh groceries".tr,
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

// ─── Top-level functions (outside any class) ───────────────────────────

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