import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shooppyy/controllers/checkout_cubit.dart';
import 'package:shooppyy/controllers/database_controller.dart';
import 'package:shooppyy/utilities/args_model/add_shipping_address_args.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/pages/bottom_nav_bar.dart';
import 'package:shooppyy/views/pages/checkout/add_shipping_Address_page.dart';
import 'package:shooppyy/views/pages/checkout/checkout_page.dart';
import 'package:shooppyy/views/pages/checkout/payment_methods_page.dart';
import 'package:shooppyy/views/pages/checkout/shipping_addresses_page.dart';
import 'package:shooppyy/views/pages/landing_page.dart';
import 'package:shooppyy/views/pages/auth_page.dart';
import 'package:shooppyy/views/pages/product_details.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
          builder: (_) => const AuthPage(), settings: settings);
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
          builder: (_) => const BottomNavBar(), settings: settings);
    case AppRoutes.productDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
          builder: (_) => Provider<Database>.value(
                value: database,
                child: ProductDetails(
                  product: product,
                ),
              ),
          settings: settings);
    case AppRoutes.checkoutPageRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
          builder: (_) => Provider<Database>.value(
                value: database,
                child: BlocProvider(
                  create: (context) => CheckoutCubit(),
                  child: const CheckoutPage(),
                ),
              ),
          settings: settings);
    case AppRoutes.addShippingAddressPage:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;
      return CupertinoPageRoute(
          builder: (_) => Provider<Database>.value(
                value: database,
                child: AddShippingAddressPage(
                  shippingAddress: shippingAddress,
                ),
              ),
          settings: settings);
    case AppRoutes.shippingAddressesPage:
      final database = settings.arguments as Database;

      return CupertinoPageRoute(
          builder: (_) => Provider<Database>.value(
                value: database,
                child: const ShippingAddressesPage(),
              ),
          settings: settings);
    case AppRoutes.paymentMethodsPage:
      return CupertinoPageRoute(
        builder: (_) => BlocProvider(
          create: (context) {
            final cubit = CheckoutCubit();
            cubit.fetchCards();
            return cubit;
          },
          child: const PaymentMethodsPage(),
        ),
      );
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
          builder: (_) => const LandingPage(), settings: settings);
  }
}
