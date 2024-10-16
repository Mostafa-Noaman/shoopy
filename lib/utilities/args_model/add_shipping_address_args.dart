import 'package:shooppyy/controllers/checkout/checkout_cubit.dart';
import 'package:shooppyy/models/shipping_address.dart';

class AddShippingAddressArgs {
  final CheckoutCubit checkoutCubit;
  final ShippingAddress? shippingAddress;

  AddShippingAddressArgs({required this.checkoutCubit, this.shippingAddress});
}
