import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:shooppyy/utilities/constants.dart';

class StripeServices {
  StripeServices._();

  static final StripeServices instance = StripeServices._();

  Future<void> makePayment(double amount, String currency) async {
    try {
      final clientSecret = await _createPaymentIntent(amount, currency);
      if (clientSecret == null) return;
      Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Shooppy',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _createPaymentIntent(double amount, String currency) async {
    try {
      final dio = Dio();
      Map<String, dynamic> body = {
        'amount': _getFinalAmount(amount),
        'currency': currency,
      };
      final headers = {
        'Authorization': 'Bearer ${AppConstants.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      };
      final response = await dio.post(
        AppConstants.paymentIntentPath,
        data: body,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: headers,
        ),
      );
      if (response.data != null) {
        debugPrint(response.data.toString());
        return response.data['client_secret'];
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  int _getFinalAmount(double amount) {
    return (amount * 100).toInt();
  }
}
