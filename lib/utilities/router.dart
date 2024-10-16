import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/checkout/checkout_cubit.dart';
import 'package:shooppyy/controllers/product_details/product_details_cubit.dart';
import 'package:shooppyy/utilities/args_model/add_shipping_address_args.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/pages/bottom_nav_bar.dart';
import 'package:shooppyy/views/pages/checkout/add_shipping_Address_page.dart';
import 'package:shooppyy/views/pages/checkout/checkout_page.dart';
import 'package:shooppyy/views/pages/checkout/payment_methods_page.dart';
import 'package:shooppyy/views/pages/checkout/shipping_addresses_page.dart';
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
      final productId = settings.arguments as String;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider(
                create: (context) {
                  final cubit = ProductDetailsCubit();
                  cubit.getProductDetails(productId);
                  return cubit;
                },
                child: const ProductDetails(),
              ),
          settings: settings);
    case AppRoutes.checkoutPageRoute:
      return CupertinoPageRoute(
          builder: (_) => BlocProvider(
                create: (context) {
                  final cubit = CheckoutCubit();
                  cubit.getCheckoutData();
                  return cubit;
                },
                child: const CheckoutPage(),
              ),
          settings: settings);
    case AppRoutes.addShippingAddressPage:
      final args = settings.arguments as AddShippingAddressArgs;
      final checkoutCubit = args.checkoutCubit;
      final shippingAddress = args.shippingAddress;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider.value(
                value: checkoutCubit,
                child: AddShippingAddressPage(
                  shippingAddress: shippingAddress,
                ),
              ),
          settings: settings);
    case AppRoutes.shippingAddressesPage:
      final checkoutCubit = settings.arguments as CheckoutCubit;
      return CupertinoPageRoute(
          builder: (_) => BlocProvider.value(
                value: checkoutCubit,
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
    default:
      return CupertinoPageRoute(
          builder: (_) => const AuthPage(), settings: settings);
  }
}
