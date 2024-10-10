import 'package:shooppyy/models/payment_method_model.dart';
import 'package:shooppyy/services/auth.dart';
import 'package:shooppyy/services/firestore_services.dart';
import 'package:shooppyy/utilities/api_path.dart';

abstract class CheckOutServices {
  Future<void> addPaymentMethod(PaymentMethod paymentMethod);

  Future<void> deletePaymentMethod(PaymentMethod paymentMethod);

  Future<List<PaymentMethod>> paymentMethods();
}

class CheckOutServicesImpl implements CheckOutServices {
  final fireStoreServices = FireStoreServices.instance;
  final authService = Auth();

  @override
  Future<void> addPaymentMethod(PaymentMethod paymentMethod) async {
    final currentUser = authService.currentUser;

    await fireStoreServices.setData(
        path: ApiPath.addCard(currentUser!.uid, paymentMethod.id),
        data: paymentMethod.toMap());
  }

  @override
  Future<void> deletePaymentMethod(PaymentMethod paymentMethod) async {
    final currentUser = authService.currentUser;

    await fireStoreServices.deleteData(
        path: ApiPath.addCard(currentUser!.uid, paymentMethod.id));
  }

  @override
  Future<List<PaymentMethod>> paymentMethods() async {
    final currentUser = authService.currentUser;
    return await fireStoreServices.getCollection(
        path: ApiPath.cards(currentUser!.uid),
        builder: (data, documentId) => PaymentMethod.fromMap(data!));
  }
}
