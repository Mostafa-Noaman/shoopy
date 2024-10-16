import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/home/home_cubit.dart';
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
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return SafeArea(
      top: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        buildWhen: (previous, current) =>
            current is HomeSuccess ||
            current is HomeLoading ||
            current is HomeFailed,
        builder: (context, state) {
          if (state is HomeLoading) {
            return const CircularProgressIndicator.adaptive();
          } else if (state is HomeFailed) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is HomeSuccess) {
            final salesProducts = state.salesProducts;
            final newProducts = state.newProducts;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        child: Text(
                          'Street Clothes',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        buildHeaderOfList(
                          context,
                          title: 'Sale',
                          description: 'Super Summer Sales!',
                        ),
                        SizedBox(
                          height: 330,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: salesProducts.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListItemHome(
                                product: salesProducts[index],
                                isNew: false,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        buildHeaderOfList(
                          context,
                          title: 'New',
                          description: 'Super New Products!',
                        ),
                        SizedBox(
                          height: 330,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: newProducts.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListItemHome(
                                product: newProducts[index],
                                isNew: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
