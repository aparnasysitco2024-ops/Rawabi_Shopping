import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:rawabi/router.dart' as router;
import 'package:rawabi/screen/home/productsFromHomeScreen.dart';
import 'package:rawabi/screen/productDetailsScreen.dart';
import 'package:rawabi/screen/splashScreen.dart';
import 'package:rawabi/utils/firebase_options.dart';
import 'package:rawabi/utils/notification/notification_storage_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print('Handling background message: ${message.messageId}');

  final notification = message.notification;
  if (notification != null) {
    await NotificationStorageService.saveNotification(
      title: notification.title ?? '',
      body: notification.body ?? '',
      data: message.data,
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(MaterialApp.router(routerConfig: router));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (_, __) => SplashScreen(),
//       routes: [
//         GoRoute(
//           path: 'details',
//           builder: (_, __) => Scaffold(
//             appBar: AppBar(title: const Text('Details Screen')),
//           ),
//         ),
//       ],
//     ),
//   ],
// );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        child: GetMaterialApp(
          routes: {
            '/': (context) => SplashScreen(),
            '/ProductDetailsScreen': (context) => ProductDetailsScreen(
                  onCartSelected: () {
                    Get.back();
                  },
                ),
            '/ProductsFromHomeScreen': (context) => ProductsFromHomeScreen(),
          },
          onGenerateRoute: router.Router.generateRoute,
          // translations: AppTranslations(),
          debugShowCheckedModeBanner: false,
          // home:   SplashScreen(),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(textScaler: TextScaler.noScaling),
                child: child!);
          },
          theme: ThemeData(
            fontFamily: Get.locale?.languageCode == 'ar' ? 'cairo' : 'openSans',
          ),
          // translations: LocalizationService(),
          supportedLocales: const [
            Locale('en', 'US'), // English, no country code
            Locale('ar', 'SA'), // Arabic, no country code
          ],

          localizationsDelegates: [
            // AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: const Locale('en', 'US'),
        ));
  }
}
