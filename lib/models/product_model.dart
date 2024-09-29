import 'package:shooppyy/utilities/app_assets.dart';

class ProductModel {
  final String id;
  final String title;
  final int price;
  final String imageUrl;
  final int? discount;
  final String category;
  final int? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.discount,
    this.category = 'other',
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imageUrl,
      'discountValue': discount,
      'category': category,
      'rate': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProductModel(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as int,
      imageUrl: map['imgUrl'] as String,
      discount: map['discountValue'] as int,
      category: map['category'] as String,
      rating: map['rate'] as int,
    );
  }
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
