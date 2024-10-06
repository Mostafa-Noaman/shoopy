import 'package:flutter/material.dart';
import 'package:shooppyy/models/delivery_method.dart';

class DeliveryMethodCard extends StatelessWidget {
  const DeliveryMethodCard({super.key, required this.deliveryMethod});
  final DeliveryMethod deliveryMethod;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white54,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Image.network(
              deliveryMethod.imgUrl,
              fit: BoxFit.cover,
              height: 50,
            ),
            const SizedBox(height: 6),
            Text(
              '${deliveryMethod.days} days',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
