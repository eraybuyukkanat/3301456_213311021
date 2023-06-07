import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app_demo/auth/auth.dart';
import 'package:social_media_app_demo/cache/shared_manager.dart';
import 'package:social_media_app_demo/config/constants.dart';
import 'package:social_media_app_demo/config/router.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view.dart';

import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/main/onboarding.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/home_page_view.dart';
import 'package:sizer/sizer.dart';
import 'package:social_media_app_demo/presentation/theme/light_theme.dart';
import 'package:easy_localization/easy_localization.dart';

int? isViewed;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  isViewed = preferences.getInt('onboarding');

  runApp(
    EasyLocalization(
        supportedLocales: [AppConstants.EN_LOCALE, AppConstants.TR_LOCALE],
        path:
            'assets/translations', // <-- change the path of the translation files

        child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          onGenerateRoute: RouteNavigation.routeNavigation,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Sosyal Medya Uygulaması',
          debugShowCheckedModeBanner: false,
          theme: LightTheme().theme,
          home: const MyHomePage(title: 'Sosyal Medya Uygulaması'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return isViewed == 1 ? LoginScreenView() : OnboardingScreen();
  }
}
