import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooppyy/controllers/database_controller.dart';
import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/utilities/app_assets.dart';
import 'package:shooppyy/views/widgets/list_item_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget buildHeaderOfList(
    BuildContext context, {
    required String title,
    required String description,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                'view All',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
        Text(
          description,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Colors.grey),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                AppAssets.topBannerHomePageImage,
                fit: BoxFit.cover,
                height: size.height * 0.3,
              ),
              Opacity(
                opacity: 0.35,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.3,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Text(
                  'Street Clothes',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                buildHeaderOfList(
                  context,
                  title: 'Sale',
                  description: 'Super Summer Sales!',
                ),
                SizedBox(
                  height: 330,
                  child: StreamBuilder<List<ProductModel>>(
                      stream: database.salesProductStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            return const Center(
                              child: Text('No data available right now.'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListItemHome(
                                product: products[index],
                                isNew: true,
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
                const SizedBox(height: 12),
                buildHeaderOfList(
                  context,
                  title: 'New',
                  description: 'Super New Products!',
                ),
                SizedBox(
                  height: 330,
                  child: StreamBuilder<List<ProductModel>>(
                      stream: database.newProductStream(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          final products = snapshot.data;
                          if (products == null || products.isEmpty) {
                            return const Center(
                              child: Text('No data is available right now.'),
                            );
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: products.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListItemHome(
                                product: products[index],
                                isNew: true,
                              ),
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
