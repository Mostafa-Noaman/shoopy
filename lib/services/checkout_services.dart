import 'package:shooppyy/models/delivery_method.dart';
import 'package:shooppyy/models/payment_method_model.dart';
import 'package:shooppyy/models/shipping_address.dart';
import 'package:shooppyy/services/auth.dart';
import 'package:shooppyy/services/firestore_services.dart';
import 'package:shooppyy/utilities/api_path.dart';

abstract class CheckOutServices {
  Future<void> setPaymentMethod(PaymentMethod paymentMethod);

  Future<void> deletePaymentMethod(PaymentMethod paymentMethod);

  Future<List<PaymentMethod>> paymentMethods();

  Future<List<ShippingAddress>> shippingAddresses(String userId);

  Future<List<DeliveryMethod>> deliveryMethods();

  Future<void> saveAddress(String userId, ShippingAddress address);
}

class CheckOutServicesImpl implements CheckOutServices {
  final fireStoreServices = FireStoreServices.instance;
  final authService = Auth();

  @override
  Future<void> setPaymentMethod(PaymentMethod paymentMethod) async {
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
  Future<List<PaymentMethod>> paymentMethods(
      [bool fetchPreferred = false]) async {
    final currentUser = authService.currentUser;
    return await fireStoreServices.getCollection(
        path: ApiPath.cards(currentUser!.uid),
        builder: (data, documentId) => PaymentMethod.fromMap(data!),
        queryBuilder: fetchPreferred == true
            ? (query) => query.where('isPreferred', isEqualTo: true)
            : null);
  }

  @override
  Future<List<DeliveryMethod>> deliveryMethods() async {
    return await fireStoreServices.getCollection(
      path: ApiPath.deliveryMethods,
      builder: (data, documentId) => DeliveryMethod.fromMap(data!, documentId),
    );
  }

  @override
  Future<void> saveAddress(String userId, ShippingAddress address) async {
    return await fireStoreServices.setData(
      path: ApiPath.newAddress(userId, address.id),
      data: address.toMap(),
    );
  }

  @override
  Future<List<ShippingAddress>> shippingAddresses(String userId) async {
    return await fireStoreServices.getCollection(
      path: ApiPath.userShippingAddress(userId),
      builder: (data, documentId) => ShippingAddress.fromMap(data!, documentId),
    );
  }
}
