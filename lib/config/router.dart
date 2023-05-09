import 'package:flutter/material.dart';
import 'package:social_media_app_demo/presentation/authpages/login.dart';

import 'package:social_media_app_demo/presentation/main/mainpage.dart';
import 'package:social_media_app_demo/presentation/pages/details/homepagedetail/communities.dart';
import 'package:social_media_app_demo/presentation/pages/details/homepagedetail/socialevents.dart';
import 'package:social_media_app_demo/presentation/pages/details/mypagedetail/chngepasswd.dart';
import 'package:social_media_app_demo/presentation/pages/details/mypagedetail/profile.dart';
import 'package:social_media_app_demo/presentation/pages/details/mypagedetail/report.dart';

class RouteNavigation {
  static Route<dynamic>? routeNavigation(RouteSettings settings) {
    switch (settings.name) {
      case '/mainpage':
        return _createRoute(
          MainPage(),
        );
      case '/authpage':
        return _createRoute(
          AuthScreen(),
        );
      case '/profile':
        return _createRoute(
          ProfilePage(),
        );
      case '/changepassword':
        return _createRoute(
          ChangePasswdPage(),
        );
      case '/report':
        return _createRoute(
          ReportErrorPage(),
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
