import 'package:shooppyy/utilities/app_assets.dart';

class ProductModel {
  final String id;
  final String title;
  final int price;
  final String imageUrl;
  final int? discount;
  final String category;
  final double? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.discount,
    this.category = 'other',
    this.rating,
  });
}

List<ProductModel> dumProducts = [
  ProductModel(
      id: '1',
      title: 'shirt',
      price: 500,
      imageUrl: AppAssets.tempProductImage,
      category: 'Women clothes',
      discount: 20),
  ProductModel(
      id: '1',
      title: 'shirt',
      price: 500,
      imageUrl: AppAssets.tempProductImage,
      category: 'Women clothes',
      discount: 20),
  ProductModel(
      id: '1',
      title: 'shirt',
      price: 500,
      imageUrl: AppAssets.tempProductImage,
      category: 'Women clothes',
      discount: 20),
  ProductModel(
      id: '1',
      title: 'shirt',
      price: 500,
      imageUrl: AppAssets.tempProductImage,
      category: 'Women clothes',
      discount: 20),
  ProductModel(
      id: '1',
      title: 'shirt',
      price: 500,
      imageUrl: AppAssets.tempProductImage,
      category: 'Women clothes',
      discount: 20),
];
