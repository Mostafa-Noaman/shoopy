import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooppyy/controllers/database_controller.dart';
import 'package:shooppyy/models/cart_model.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/widgets/cart_list_item.dart';
import 'package:shooppyy/views/widgets/cart_price_row.dart';

import '../widgets/main_button.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int totalAmount = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final products = await Provider.of<Database>(context, listen: false)
        .myProductsCart()
        .first;
    products.forEach(
      (element) {
        setState(() {
          totalAmount += element.price;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<CartModel>>(
          stream: database.myProductsCart(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final cartItems = snapshot.data;
              debugPrint('this is ======== $cartItems');

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox.shrink(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.search),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        'My Cart',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      if (cartItems == null || cartItems.isEmpty)
                        Center(
                          child: Text(
                            'No Data Available!',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      if (cartItems != null && cartItems.isNotEmpty)
                        ListView.builder(
                          itemCount: cartItems.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            final cartItem = cartItems[i];
                            return CartListItem(
                              cartItem: cartItem,
                            );
                          },
                        ),
                      const SizedBox(height: 24.0),
                      CartPriceRow(
                        title: 'Total amount',
                        priceValue: totalAmount.toString(),
                      ),
                      const SizedBox(height: 32.0),
                      MainButton(
                        text: 'Checkout',
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed(
                              AppRoutes.checkoutPageRoute,
                              arguments: database);
                        },
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
