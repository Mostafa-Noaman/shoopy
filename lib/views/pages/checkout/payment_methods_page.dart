import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/checkout_cubit.dart';
import 'package:shooppyy/views/widgets/checkout/add_new_card_bottom_sheet.dart';
import 'package:shooppyy/views/widgets/main_button.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final checkOutCubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
      ),
      body: BlocBuilder<CheckoutCubit, CheckoutState>(
        bloc: checkOutCubit,
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
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit_rounded),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.delete_rounded),
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
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (_) {
                              return BlocProvider.value(
                                value: checkOutCubit,
                                child: const AddNewCardBottomSheet(),
                              );
                            }).then((value) => checkOutCubit.fetchCards());
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
