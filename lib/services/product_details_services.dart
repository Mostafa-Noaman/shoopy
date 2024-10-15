import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/services/firestore_services.dart';
import 'package:shooppyy/utilities/api_path.dart';

abstract class ProductDetailsServices {
  Future<ProductModel> getProductDetails(String productId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final firestoreServices = FireStoreServices.instance;

  @override
  Future<ProductModel> getProductDetails(String productId) async {
    return await firestoreServices.getDocument(
      path: ApiPath.product(productId),
      builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
    );
  }
}
