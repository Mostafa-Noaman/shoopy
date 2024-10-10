import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shooppyy/models/payment_method_model.dart';
import 'package:shooppyy/services/checkout_services.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final checkOutService = CheckOutServicesImpl();

  Future<void> addCard(PaymentMethod paymentMethod) async {
    emit(AddingCards());
    try {
      await checkOutService.addPaymentMethod(paymentMethod);
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
    emit(DeletingCards());
    try {
      await checkOutService.deletePaymentMethod(paymentMethod);
      emit(CardsDeleted());
    } catch (e) {
      emit(DeleteCardsFailed(e.toString()));
    }
  }
}
