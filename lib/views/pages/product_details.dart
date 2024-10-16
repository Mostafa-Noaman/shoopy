import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/product_details/product_details_cubit.dart';
import 'package:shooppyy/views/widgets/drop_down_menu.dart';
import 'package:shooppyy/views/widgets/main_button.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  late String dropDownValue;

  // Future<void> addToCart(Database database) async {
  //   try {
  //     final cartProduct = AddToCartModel(
  //         id: documentIdFromLocalData(),
  //         productId: widget.product.id,
  //         title: widget.product.title,
  //         price: widget.product.price,
  //         imageUrl: widget.product.imageUrl,
  //         size: dropDownValue);
  //     debugPrint(cartProduct.toMap().toString());
  //     await database.addToCart(cartProduct);
  //   } catch (e) {
  //     return MainDialog(context: context, title: 'Error', content: e.toString())
  //         .showAlertDialog();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final productDetailsCubit = BlocProvider.of<ProductDetailsCubit>(context);
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      bloc: productDetailsCubit,
      buildWhen: (previous, current) =>
          current is ProductDetailsLoading ||
          current is ProductDetailsLoaded ||
          current is ProductDetailsError,
      builder: (context, state) {
        if (state is ProductDetailsLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        } else if (state is ProductDetailsError) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        } else if (state is ProductDetailsLoaded) {
          final product = state.product;
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: DropDownMenu(
                                items: const ['S', 'M', 'L', 'XL', 'XXL'],
                                hint: 'Size',
                                onChanged: (value) {
                                  productDetailsCubit.setSize(value!);
                                },
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isFavorite != isFavorite;
                                });
                              },
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      size: 35,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                        BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
                          bloc: productDetailsCubit,
                          listenWhen: (previous, current) =>
                              current is AddedToCart ||
                              current is AddToCartError,
                          listener: (context, state) {
                            if (state is AddedToCart) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Added to cart successfully.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else if (state is AddToCartError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(state.error),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is AddingToCart) {
                              return MainButton(
                                child:
                                    const CircularProgressIndicator.adaptive(),
                              );
                            }
                            return MainButton(
                                text: 'Add to cart',
                                onTap: () async {
                                  await productDetailsCubit.addToCart(product);
                                });
                          },
                        ),
                        const SizedBox(height: 32),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
