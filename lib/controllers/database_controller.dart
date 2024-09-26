import 'package:shooppyy/models/product_model.dart';
import 'package:shooppyy/services/firestore_services.dart';

abstract class Database {
  Stream<List<ProductModel>> productStream();
}

class FireStoreDatabase implements Database {
  final _service = FireStoreServices.instance;

  @override
  Stream<List<ProductModel>> productStream() => _service.collectionStream(
        path: 'products/',
        builder: (data, documentId) => ProductModel.fromMap(data!, documentId),
      );
}
