import 'package:flutter/material.dart';
import 'package:shooppyy/views/widgets/cart_price_row.dart';

class CheckoutOrderDetails extends StatelessWidget {
  const CheckoutOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        CartPriceRow(title: 'Order', priceValue: '125\$'),
        SizedBox(height: 8),
        CartPriceRow(title: 'Delivery', priceValue: '25\$'),
        SizedBox(height: 8),
        CartPriceRow(title: 'Summary', priceValue: '150\$'),
      ],
    );
  }
}
