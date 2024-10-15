import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/services/firestore_services.dart';
import 'package:shooppyy/utilities/api_path.dart';

abstract class HomeServices {
  Future<List<ProductModel>> getSalesProducts();

  Future<List<ProductModel>> getNewProducts();
}

class HomeServicesImpl implements HomeServices {
  final firestoreServices = FireStoreServices.instance;

  @override
  Future<List<ProductModel>> getNewProducts() async {
    return await firestoreServices.getCollection(
      path: ApiPath.products,
      builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
    );
  }

  @override
  Future<List<ProductModel>> getSalesProducts() async {
    return await firestoreServices.getCollection(
      path: ApiPath.products,
      builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      queryBuilder: (query) => query.where('discountValue', isNotEqualTo: 0),
    );
  }
}
