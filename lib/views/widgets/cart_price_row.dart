import 'package:flutter/material.dart';

class CartPriceRow extends StatelessWidget {
  const CartPriceRow(
      {super.key, required this.title, required this.priceValue});

  final String title;
  final String priceValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.grey),
        ),
        Text(
          priceValue,
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
