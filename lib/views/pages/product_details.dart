import 'package:flutter/material.dart';
import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/views/widgets/main_button.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.share,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              product.imageUrl,
              width: double.infinity,
              height: size.height * 0.5,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.favorite_border_rounded),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      Text(
                        '\$${product.price}',
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.category,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'dummy data will change in the next video which i will watch today.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  MainButton(text: 'Add to cart', onTap: () {}),
                  const SizedBox(height: 32),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
