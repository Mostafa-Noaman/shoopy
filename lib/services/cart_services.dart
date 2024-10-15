import 'package:shooppyy/models/add_to_cart_model.dart';
import 'package:shooppyy/services/firestore_services.dart';
import 'package:shooppyy/utilities/api_path.dart';

abstract class CartServices {
  Future<void> addProductToCart(String userId, AddToCartModel cartProduct);

  Future<List<AddToCartModel>> getCartProducts(String userId);
}

class CartServicesImpl implements CartServices {
  final firestoreServices = FireStoreServices.instance;

  @override
  Future<void> addProductToCart(
      String userId, AddToCartModel cartProduct) async {
    return await firestoreServices.setData(
        path: ApiPath.addToCart(userId, cartProduct.id),
        data: cartProduct.toMap());
  }

  @override
  Future<List<AddToCartModel>> getCartProducts(String userId) async {
    return await firestoreServices.getCollection(
      path: ApiPath.myProductCart(userId),
      builder: (data, documentId) => AddToCartModel.fromMap(data!, documentId),
    );
  }
}
