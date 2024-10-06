import 'package:flutter/material.dart';
import 'package:shooppyy/utilities/app_assets.dart';

class PaymentComponent extends StatelessWidget {
  const PaymentComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              AppAssets.masterCardImage,
              fit: BoxFit.cover,
              height: 40,
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Text('**** **** **** *354'),
      ],
    );
  }
}
