import 'package:flutter/material.dart';

class ShippingAddressComponent extends StatelessWidget {
  const ShippingAddressComponent({super.key});

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
                  'Full Name',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap: () {},
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
              'street address',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'city address',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
