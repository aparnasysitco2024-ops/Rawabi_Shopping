import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rawabi/utils/app_utils.dart';

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

    await Permission.location
        .onDeniedCallback(() {
          print("-----------1------------");
      // Your code
    })
        .onGrantedCallback(() {
      // Your code
      print("----------6-------------");
      firebase();

    })
        .onPermanentlyDeniedCallback(() {
      print("----------2-------------");
      firebase();
      // Your code
    })
        .onRestrictedCallback(() {
      print("---------3--------------");
      // Your code
    })
        .onLimitedCallback(() {
      print("----------4-------------");
      // Your code
    })
        .onProvisionalCallback(() {
      print("----------5-------------");
      // Your code
    })
        .request();
  }

  Future<void> initialize() async {
    var prefValue =
        await StorageManager.readData(StorageManager.sharedPrfValue);
    if (prefValue.isEmpty) {
      StorageManager.clearData();
      StorageManager.saveData(StorageManager.sharedPrfValue, "1");
    }


    permission();
    // getLanguageData();
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
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/splash.png"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset("assets/icons/logo.svg",height: 80,),
                SizedBox(height: 10,),
                ReusableText(
                    textAlign: TextAlign.center,
                    title: "Get your groceries delivered to your home".tr,
                    size: 20,
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
                    size: 16,
                    color: grey,
                    weight: FontWeight.w400),
                const SizedBox(
                  height: 20,
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
      }
      // else
      // print("t------: "+await StorageManager.readData(StorageManager.keyFirebaseToken));

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
