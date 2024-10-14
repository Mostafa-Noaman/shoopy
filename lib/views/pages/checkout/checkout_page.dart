import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shooppyy/controllers/checkout_cubit.dart';
import 'package:shooppyy/controllers/database_controller.dart';
import 'package:shooppyy/models/delivery_method.dart';
import 'package:shooppyy/models/shipping_address.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/widgets/checkout/checkout_order_details.dart';
import 'package:shooppyy/views/widgets/checkout/delivery_method_card.dart';
import 'package:shooppyy/views/widgets/checkout/payment_component.dart';
import 'package:shooppyy/views/widgets/checkout/shipping_address_component.dart';
import 'package:shooppyy/views/widgets/main_button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CheckOut'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shipping Address',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              StreamBuilder<List<ShippingAddress>>(
                  stream: database.getDefaultShippingAddress(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final shippingAddresses = snapshot.data;
                      if (shippingAddresses == null ||
                          shippingAddresses.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const Text('No shipping addresses'),
                              const SizedBox(height: 6),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.addShippingAddressPage,
                                      arguments: database);
                                },
                                child: Text(
                                  'Add a new address.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      final shippingAddressVariable = shippingAddresses.first;
                      return ShippingAddressComponent(
                        shippingAddress: shippingAddressVariable,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Payment',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRoutes.paymentMethodsPage);
                    },
                    child: Text(
                      'Change',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const PaymentComponent(),
              const SizedBox(height: 24),
              Text(
                'Delivery Method',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              StreamBuilder<List<DeliveryMethod>>(
                  stream: database.deliveryMethodStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final deliveryMethod = snapshot.data;
                      if (deliveryMethod == null || deliveryMethod.isEmpty) {
                        return const Center(
                          child: Text('No delivery methods available'),
                        );
                      }
                      return SizedBox(
                        height: size.height * 0.1,
                        child: ListView.builder(
                          itemCount: deliveryMethod.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: DeliveryMethodCard(
                                deliveryMethod: deliveryMethod[index]),
                          ),
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }),
              const SizedBox(height: 32),
              const CheckoutOrderDetails(),
              const SizedBox(height: 64),
              BlocConsumer<CheckoutCubit, CheckoutState>(
                bloc: checkoutCubit,
                listenWhen: (previous, current) =>
                    current is PaymentMade ||
                    current is MakingPayment ||
                    current is PaymentMakingFailed,
                listener: (context, state) {
                  if (state is PaymentMakingFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is PaymentMade) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Success'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    current is PaymentMade ||
                    current is MakingPayment ||
                    current is PaymentMakingFailed,
                builder: (context, state) {
                  if (state is MakingPayment) {
                    MainButton(
                      child: const CircularProgressIndicator.adaptive(),
                    );
                  }
                  return MainButton(
                      text: 'Submit Order',
                      onTap: () async {
                        await checkoutCubit.makePayment(450);
                      });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
