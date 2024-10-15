import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shooppyy/models/delivery_method.dart';
import 'package:shooppyy/models/payment_method_model.dart';
import 'package:shooppyy/models/shipping_address.dart';
import 'package:shooppyy/services/auth_services.dart';
import 'package:shooppyy/services/checkout_services.dart';
import 'package:shooppyy/services/stripe_services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkOutService = CheckOutServicesImpl();
  final authServices = AuthServicesImpl();
  final stripeServices = StripeServices.instance;

  Future<void> makePayment(double amount) async {
    emit(MakingPayment());
    try {
      await stripeServices.makePayment(amount, 'usd');
      emit(PaymentMade());
    } catch (e) {
      emit(PaymentMakingFailed(e.toString()));
    }
  }

  Future<void> addCard(PaymentMethod paymentMethod) async {
    emit(AddingCards());
    try {
      await checkOutService.setPaymentMethod(paymentMethod);
      emit(CardsAdded());
    } catch (e) {
      emit(CardsAddingFailed(e.toString()));
    }
  }

  Future<void> fetchCards() async {
    emit(FetchingCards());
    try {
      final paymentMethod = await checkOutService.paymentMethods();
      emit(CardsFetched(paymentMethod));
    } catch (e) {
      emit(CardsFetchingFailed(e.toString()));
    }
  }

  Future<void> deleteCard(PaymentMethod paymentMethod) async {
    emit(DeletingCards(paymentMethod.id));
    try {
      await checkOutService.deletePaymentMethod(paymentMethod);
      emit(CardsDeleted());
      await fetchCards();
    } catch (e) {
      emit(DeleteCardsFailed(e.toString()));
    }
  }

  Future<void> makePreferred(PaymentMethod paymentMethod) async {
    emit(FetchingCards());
    try {
      final preferredPaymentMethods =
          await checkOutService.paymentMethods(true);
      for (var method in preferredPaymentMethods) {
        final newPaymentMethod = method.copyWith(isPreferred: false);
        await checkOutService.setPaymentMethod(newPaymentMethod);
      }
      final newPreferredMethod = paymentMethod.copyWith(isPreferred: true);
      await checkOutService.setPaymentMethod(newPreferredMethod);
      emit(PreferredMade());
    } catch (e) {
      emit(PreferredMakingFailed(e.toString()));
    }
  }

  Future<void> getCheckoutData() async {
    emit(CheckoutLoading());
    try {
      final currentUser = authServices.currentUser;
      final shippingAddresses =
          await checkOutService.shippingAddresses(currentUser!.uid);
      final deliveryMethods = await checkOutService.deliveryMethods();
      emit(CheckoutLoaded(
        deliveryMethods: deliveryMethods,
        shippingAddress:
            shippingAddresses.isEmpty ? null : shippingAddresses[0],
      ));
    } catch (e) {
      emit(CheckoutLoadingFailed(e.toString()));
    }
  }

  Future<void> getShippingAddresses() async {
    emit(FetchingAddresses());
    try {
      final currentUser = authServices.currentUser;
      final shippingAddresses =
          await checkOutService.shippingAddresses(currentUser!.uid);

      emit(AddressesFetched(shippingAddresses));
    } catch (e) {
      emit(AddressesFetchingFailed(e.toString()));
    }
  }

  Future<void> saveAddress(ShippingAddress address) async {
    emit(AddingAddress());
    try {
      final currentUser = authServices.currentUser;
      await checkOutService.saveAddress(currentUser!.uid, address);
      emit(AddressAdded());
    } catch (e) {
      emit(AddressAddingFailed(e.toString()));
    }
  }
}
