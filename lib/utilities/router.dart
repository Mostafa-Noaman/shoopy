import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/pages/landing_page.dart';
import 'package:shooppyy/views/pages/auth_page.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(builder: (_) => AuthPage());
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(builder: (_) => const LandingPage());
  }
}
