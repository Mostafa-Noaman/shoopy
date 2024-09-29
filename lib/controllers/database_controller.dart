import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/services/firestore_services.dart';
import 'package:shooppyy/utilities/api_path.dart';

abstract class Database {
  Stream<List<ProductModel>> salesProductStream();

  Stream<List<ProductModel>> newProductStream();
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
}
