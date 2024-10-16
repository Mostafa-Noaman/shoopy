import 'package:flutter/material.dart';
import 'package:shooppyy/controllers/checkout/checkout_cubit.dart';
import 'package:shooppyy/models/shipping_address.dart';
import 'package:shooppyy/utilities/routes.dart';

class ShippingAddressComponent extends StatelessWidget {
  const ShippingAddressComponent({
    super.key,
    required this.shippingAddress,
    required this.checkoutCubit,
  });

  final ShippingAddress shippingAddress;
  final CheckoutCubit checkoutCubit;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  shippingAddress.fullName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        AppRoutes.shippingAddressesPage,
                        arguments: checkoutCubit);
                  },
                  child: Text(
                    'Change',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              shippingAddress.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${shippingAddress.city},${shippingAddress.state},${shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
