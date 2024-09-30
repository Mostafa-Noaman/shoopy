import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/pages/bottom_nav_bar.dart';
import 'package:shooppyy/views/pages/landing_page.dart';
import 'package:shooppyy/views/pages/auth_page.dart';
import 'package:shooppyy/views/pages/product_details.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(builder: (_) => AuthPage(), settings: settings);
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
          builder: (_) => BottomNavBar(), settings: settings);
    case AppRoutes.productDetailsRoute:
      final product = settings.arguments as ProductModel;
      return CupertinoPageRoute(
          builder: (_) => ProductDetails(
                product: product,
              ),
          settings: settings);
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
  }
}
