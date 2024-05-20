import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rawabi/screen/splashScreen.dart';
import 'dart:async';

import 'package:rawabi/utils/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
          // translations: AppTranslations(),
          debugShowCheckedModeBanner: false,
          home:   SplashScreen(),
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
                child: child!);
          },
          // translations: LocalizationService(),
          supportedLocales: const [
            Locale('en', 'US'), // English, no country code
            Locale('ar', 'SA'), // Arabic, no country code
          ],
          // localizationsDelegates: const [
          //   // AppLocalizations.delegate,
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
          locale: const Locale('en', 'US'),
        ));
  }
}





