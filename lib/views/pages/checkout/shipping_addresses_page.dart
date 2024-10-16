import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/checkout/checkout_cubit.dart';
import 'package:shooppyy/utilities/args_model/add_shipping_address_args.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/widgets/checkout/shipping_address_state_item.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckoutCubit>(context).getShippingAddresses();
  }

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Addresses'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            bloc: checkoutCubit,
            buildWhen: (previous, current) =>
                current is FetchingAddresses ||
                current is AddressesFetched ||
                current is AddressesFetchingFailed,
            builder: (context, state) {
              if (state is FetchingAddresses) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is AddressesFetchingFailed) {
                return Center(
                  child: Text(state.error),
                );
              } else if (state is AddressesFetched) {
                final shippingAddresses = state.shippingAddresses;
                return Column(
                  children: shippingAddresses
                      .map(
                        (shippingAddress) => ShippingAddressStateItem(
                            shippingAddress: shippingAddress),
                      )
                      .toList(),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addShippingAddressPage,
              arguments: AddShippingAddressArgs(checkoutCubit: checkoutCubit));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
