import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/authpages/login/login_view.dart';

import 'package:social_media_app_demo/presentation/authpages/register/register_view.dart';

import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/communities/communities.dart';
import 'package:social_media_app_demo/presentation/pages/home_page/socialevents/socialevents.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/chngepasswd/chngepasswd_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/profile/profile_view.dart';
import 'package:social_media_app_demo/presentation/pages/settings_page/pages/report/report_view.dart';

class RouteNavigation {
  static Route<dynamic>? routeNavigation(RouteSettings settings) {
    switch (settings.name) {
      case '/mainpage':
        return _createRoute(
          MainPage(),
        );
      case '/loginpage':
        return _createRoute(
          LoginScreenView(),
        );
      case '/registerpage':
        return _createRoute(
          RegisterScreenView(),
        );
      case '/profile':
        return _createRoute(
          ProfilePageView(),
        );
      case '/changepassword':
        return _createRoute(
          ChangePasswdPageView(),
        );
      case '/report':
        return _createRoute(
          ReportErrorView(),
        );
      case '/communities':
        return _createRoute(
          CommunitiesPage(),
        );
      case '/socialevents':
        return _createRoute(
          SocialEventsPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text("error"),
            ),
          ),
        );
        break;
    }
  }

  static _createRoute(Widget _gidilecekWidget) {
    return MaterialPageRoute(
      builder: (context) => _gidilecekWidget,
    );
  }
}
