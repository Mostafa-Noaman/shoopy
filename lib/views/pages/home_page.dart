import 'package:flutter/material.dart';
import 'package:shooppyy/utilities/app_assets.dart';

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
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Text(
                'Street Clothes',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              buildHeaderOfList(
                context,
                title: 'Sale',
                description: 'Super Summer Sales!',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
