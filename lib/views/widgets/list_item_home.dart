import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/utilities/routes.dart';

class ListItemHome extends StatelessWidget {
  const ListItemHome({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isFavorite = false;
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(AppRoutes.productDetailsRoute, arguments: product);
      },
      child: DecoratedBox(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Stack(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrl,
                      height: size.height * 0.22,
                      width: size.width * 0.4,
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
                  ),
                ],
              ),
              Positioned(
                left: size.width * 0.31,
                bottom: size.height * 0.09,
                child: Container(
                  decoration:
                      const BoxDecoration(shape: BoxShape.circle, boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      color: Colors.grey,
                    ),
                  ]),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Icon(
                        isFavorite
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        size: 20,
                        color: isFavorite ? Colors.red : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Positioned(
                bottom: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),
                    Row(
                      children: [
                        RatingBarIndicator(
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemSize: 22,
                          rating: product.rating?.toDouble() ?? 0.0,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          '(12)',
                          style: Theme.of(context).textTheme.labelSmall,
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
                      style: Theme.of(context).textTheme.titleLarge,
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
            ],
          ),
        ),
      ),
    );
  }
}
