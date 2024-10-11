import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/checkout_cubit.dart';
import 'package:shooppyy/models/payment_method_model.dart';
import 'package:shooppyy/views/widgets/checkout/add_new_card_bottom_sheet.dart';
import 'package:shooppyy/views/widgets/main_button.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkOutCubit = BlocProvider.of<CheckoutCubit>(context);
    Future<void> showBottomSheet([PaymentMethod? paymentMethod]) async {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return BlocProvider.value(
              value: checkOutCubit,
              child: AddNewCardBottomSheet(
                paymentMethod: paymentMethod,
              ),
            );
          }).then((value) => checkOutCubit.fetchCards());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: BlocConsumer<CheckoutCubit, CheckoutState>(
        bloc: checkOutCubit,
        listenWhen: (previous, current) =>
            current is PreferredMade || current is PreferredMakingFailed,
        listener: (context, state) {
          if (state is PreferredMade) {
            Navigator.of(context).pop();
          } else if (state is PreferredMakingFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ));
          }
        },
        buildWhen: (previous, current) =>
            current is FetchingCards ||
            current is CardsFetched ||
            current is CardsFetchingFailed,
        builder: (context, state) {
          if (state is FetchingCards) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is CardsFetchingFailed) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is CardsFetched) {
            final paymentMethods = state.paymentMethod;
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Your payment cards',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paymentMethods.length,
                      itemBuilder: (context, index) {
                        final payment = paymentMethods[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.credit_card_rounded),
                                      const SizedBox(width: 8),
                                      Text(payment.cardNumber),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showBottomSheet(payment);
                                        },
                                        icon: const Icon(Icons.edit_rounded),
                                      ),
                                      BlocBuilder<CheckoutCubit, CheckoutState>(
                                        bloc: checkOutCubit,
                                        buildWhen: (previous, current) =>
                                            (current is DeletingCards &&
                                                current.id == payment.id) ||
                                            current is CardsDeleted ||
                                            current is DeleteCardsFailed,
                                        builder: (context, state) {
                                          if (state is DeletingCards) {
                                            return const CircularProgressIndicator
                                                .adaptive();
                                          }
                                          return IconButton(
                                            onPressed: () async {
                                              await checkOutCubit
                                                  .deleteCard(payment);
                                            },
                                            icon: const Icon(
                                                Icons.delete_rounded),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    MainButton(
                      text: 'Add new card',
                      onTap: () {
                        showBottomSheet();
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
