import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/models/cart_model.dart';
import 'package:shooppyy/models/user_model.dart';
import 'package:shooppyy/services/firestore_services.dart';
import 'package:shooppyy/utilities/api_path.dart';

abstract class Database {
  Stream<List<ProductModel>> salesProductStream();

  Stream<List<ProductModel>> newProductStream();

  Stream<List<CartModel>> myProductsCart();

  Future<void> setUserData(UserModel userData);

  Future<void> addToCart(CartModel product);
}

class FireStoreDatabase implements Database {
  final _service = FireStoreServices.instance;
  final String uId;

  FireStoreDatabase(this.uId);

  @override
  Stream<List<ProductModel>> salesProductStream() => _service.collectionStream(
      path: ApiPath.products,
      builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0));

  @override
  Stream<List<ProductModel>> newProductStream() => _service.collectionStream(
        path: ApiPath.products,
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );

  @override
  Future<void> setUserData(UserModel userData) async => await _service.setData(
      path: ApiPath.user(userData.uId), data: userData.toMap());

  @override
  Future<void> addToCart(CartModel product) async => await _service.setData(
      path: ApiPath.addToCart(uId, product.id), data: product.toMap());

  @override
  Stream<List<CartModel>> myProductsCart() => _service.collectionStream(
        path: ApiPath.myProductCart(uId),
        builder: (data, documentId) => CartModel.fromMap(
          data!,
          documentId,
        ),
      );
}
