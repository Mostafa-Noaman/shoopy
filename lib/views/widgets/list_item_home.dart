import 'package:flutter/material.dart';
import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/utilities/app_assets.dart';

class ListItemHome extends StatelessWidget {
  const ListItemHome({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    product.imageUrl,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20,
                  width: 35,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        '${product.discount.toString()}%',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              product.category,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: Colors.grey),
            ),
            Text(
              product.title,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              '${product.price.toString()}\$',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
