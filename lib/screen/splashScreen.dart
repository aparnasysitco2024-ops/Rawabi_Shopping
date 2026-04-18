import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rawabi/utils/app_utils.dart';
import 'package:rawabi/utils/notification/notificationData.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/response/languageParamResponse.dart';
import '../utils/colors.dart';
import '../utils/storage_manager.dart';
import '../widget/commonWidget/reusable_text.dart';
import 'deliverymode/deliveryModeScreen.dart';
import 'navigator/bottomNavBar.dart';

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
  @override
  void initState() {
    super.initState();
    initialize();
  }

  permission() async {
    await Permission.location.onDeniedCallback(() {
      // Your code
    }).onGrantedCallback(() {
      // Your code
      firebase();
    }).onPermanentlyDeniedCallback(() {
      firebase();
      // Your code
    }).onRestrictedCallback(() {
      // Your code
    }).onLimitedCallback(() {
      // Your code
    }).onProvisionalCallback(() {
      // Your code
    }).request();
  }

  Future<void> initialize() async {
    ///only for this time
    await _clearCacheIfOldVersion();

    var prefValue =
        await StorageManager.readData(StorageManager.sharedPrfValue);
    if (prefValue != "2") {
      StorageManager.clearData();
      StorageManager.saveData(StorageManager.sharedPrfValue, "2");
    }

    if (!await StorageManager.readDataBool(StorageManager.keyIsLogin)) {
      StorageManager.saveData(StorageManager.keyUserID, "0");
    }

    permission();
    // getLanguageData();
  }

  Future<void> _clearCacheIfOldVersion() async {
    try {
      String alreadyCleared = await StorageManager.readData("keyCacheCleared_1.0.40");
      if (alreadyCleared == "true") {
        print("⏭️ Cache already cleared once for this update → Skipping");
        return;
      }

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      print("📱 Current app version: $currentVersion");
      print("🎯 Target version: 1.0.40");

      if (_isVersionGreaterThan(currentVersion, "1.0.40")) {
        await StorageManager.clearData();

        // ⚠️ Save BOTH flags immediately so initialize() doesn't clear again
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("keyCacheCleared_1.0.40", "true");
        await prefs.setString(StorageManager.sharedPrfValue, "2"); // prevent clearData() in initialize()

        print("✅ Version $currentVersion is GREATER than 1.0.40 → Cache & StorageManager CLEARED successfully");
      } else {
        print("🚫 Version $currentVersion is NOT greater than 1.0.40 → Cache NOT cleared, proceeding normally");
      }
    } catch (e) {
      print("❌ Version check error: $e");
    }
  }

  bool _isVersionGreaterThan(String current, String target) {
    List<int> currentParts = current.split('.').map(int.parse).toList();
    List<int> targetParts = target.split('.').map(int.parse).toList();

    while (currentParts.length < targetParts.length) currentParts.add(0);
    while (targetParts.length < currentParts.length) targetParts.add(0);

    for (int i = 0; i < currentParts.length; i++) {
      if (currentParts[i] > targetParts[i]) return true;
      if (currentParts[i] < targetParts[i]) return false;
    }
    return false; // equal versions → don't clear
  }

  moveToPage() {
    Timer(const Duration(seconds: 1), () async {
      String storeAddress =
          await StorageManager.readData(StorageManager.keyStoreAddress);
      if (storeAddress.isEmpty) {
        AppUtils.navigateToPage(DeliveryModeScreen());
      } else {
        AppUtils.navigateToPageReplace(BottomNavBar(
          productId: widget.productId,
        ));
      }
    });
  }

  Future<void> getLanguageData() async {
    widget.languageParamString =
        await StorageManager.readData(StorageManager.keyLanguageParams);
    if (widget.languageParamString.isNotEmpty) {
      // widget.languageParam.value =
      //     LanguageParam.fromJson(json.decode(widget.languageParamString));
      moveToPage();
    } else
      readJsonLanguage();
  }

  Future<void> readJsonLanguage() async {
    final String response =
        await rootBundle.loadString('assets/json/englishLanguage.json');
    widget.languageParam.value = LanguageParam.fromJson(json.decode(response));
    StorageManager.saveData(StorageManager.keyLanguageParams,
        json.encode(widget.languageParam.value));
    moveToPage();
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
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  "assets/icons/logo.svg",
                  height: 80,
                ),
                SizedBox(
                  height: 10,
                ),
                ReusableText(
                    textAlign: TextAlign.center,
                    title: "Get your groceries delivered to your home".tr,
                    size: 19,
                    color: blackLight,
                    weight: FontWeight.bold),
                const SizedBox(
                  height: 10,
                ),
                ReusableText(
                    textAlign: TextAlign.center,
                    title:
                        "The best delivery app in town for delivering your daily fresh groceries"
                            .tr,
                    size: 15,
                    color: grey,
                    weight: FontWeight.w400),
                const SizedBox(
                  height: 50,
                ),
                // ReusableButton(
                //     width: 200.0,
                //     onTap: () {
                //       AppUtils.navigateToPageReplace(const BottomNavBar());
                //     },
                //     title: "Shop now".tr)
              ],
            ),
          )),
    );
  }

  Future<void> firebase() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
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

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.max,
      );
      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      // To handle Error(Red screen of death) globally.
      // If there is any red screen will appear app will rederict to the login screen .. temp solution
      ErrorWidget.builder = (FlutterErrorDetails details) => SplashScreen();
      if (await StorageManager.readData(StorageManager.keyFirebaseToken) ==
          "") {
        final fcmToken = await FirebaseMessaging.instance.getToken();

        StorageManager.saveData(StorageManager.keyFirebaseToken, fcmToken);
        // updatePushToken(fcmToken.toString());
        await FirebaseMessaging.instance.subscribeToTopic("all");
        print("token------------------------: " + fcmToken.toString());
        Future.delayed(const Duration(seconds: 1), () async {
          await subscribeToTopicWithRetry(topic: 'rawabi_user');
        });
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        print('Got a message whilst in the foreground!');
        if (message.notification != null && android != null) {
          print('Notification Title: ${message.notification!.title}');
          print('Notification Body: ${message.notification!.body}');
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification!.title,
              notification.body,
              payload: jsonEncode(message.data).toString(),
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  icon: '@drawable/launcher_icon',
                  // other properties...
                ),
              ));
        }
      });

      var androidSettings =
          const AndroidInitializationSettings('@mipmap/ic_launcher');
      var initSettings = InitializationSettings(android: androidSettings);

      final FlutterLocalNotificationsPlugin _notificationsPlugin =
          FlutterLocalNotificationsPlugin();

      _notificationsPlugin.initialize(initSettings,
          onDidReceiveBackgroundNotificationResponse: (details) {
        print("details;---------" + details.payload.toString());
        _handleNotificationClick(details.payload.toString());
      }, onDidReceiveNotificationResponse: (details) {
        print("details;---------" + details.payload.toString());
        _handleNotificationClick(details.payload.toString());
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (context.mounted) {
          _handleNotificationClick1(context, message);
        }
      });

      FirebaseMessaging.instance.getInitialMessage().then((value) {
        _handleNotificationClick1(context, value!);
      },);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      getLanguageData();
    } catch (e) {
      print("-------------------firebase error-------------------");
      print(e..printError());
      getLanguageData();
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

        // Save subscription status
        //await NotificationStorageService.saveTopicSubscriptionStatus(true);
        return true;

      } catch (e) {
        print('Attempt $attempt failed for topic $topic: $e');

        if (attempt == maxRetries) {
          print('Max retries reached for topic $topic');
          //await NotificationStorageService.saveTopicSubscriptionStatus(false);
          return false;
        }

        // Exponential backoff: 2s, 4s, 8s, 16s, 32s
        final delay = initialDelay * (1 << (attempt - 1));
        print('Retrying in ${delay.inSeconds} seconds...');
        await Future.delayed(delay);
      }
    }
    return false;
  }

// Future<void> updatePushToken(String token) async {
//   try {
//     var params = {"pushtoken": token};
//     var response = await BaseClient().post(pushTokenUrl, params);
//     if (response != null) {
//       var responseData =
//           LanguageParamResponse.fromJson(json.decode(response.toString()));
//       if (responseData.code == "200") {
//         StorageManager.saveData(StorageManager.keyFirebaseToken, token);
//       }
//     }
//   } catch (error) {
//     error.printError();
//   }
// }
}

void _handleNotificationClick(String payload) {
  var responseData = NotificationData.fromJson(json.decode(payload));

  if (responseData.type == "product") {
    Navigator.pushNamed(
      Get.context!,
      '/ProductDetailsScreen',
      arguments: {
        'productID': responseData.id.toString(),
      },
    );
  } else if (responseData.type == "itemgroup") {
    Navigator.pushNamed(
      Get.context!,
      '/ProductsFromHomeScreen',
      arguments: {'title': "", "grp_id": responseData.id.toString()},
    );
  }
  // print("type------------------------: " + responseData.type.toString());
  // print("id------------------------: " + responseData.id.toString());
}

void _handleNotificationClick1(BuildContext context, RemoteMessage message) {
  final notificationData = message.data;

  Timer(const Duration(seconds: 1), () async {



  if (notificationData.containsKey('type')) {
    final type = notificationData['type'];
    final id = notificationData['id'];
    if (type == "product") {
      Navigator.pushNamed(
        context,
        '/ProductDetailsScreen',
        arguments: {
          'productID': id.toString(),
        },
      );
    } else if (type == "itemgroup") {
      Navigator.pushNamed(
        context,
        '/ProductsFromHomeScreen',
        arguments: {'title': "", "grp_id": id.toString()},
      );
    }
  }  });
}
