import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooppyy/controllers/database_controller.dart';
import 'package:shooppyy/models/shipping_address.dart';
import 'package:shooppyy/utilities/args_model/add_shipping_address_args.dart';
import 'package:shooppyy/utilities/routes.dart';
import 'package:shooppyy/views/widgets/checkout/shipping_address_component.dart';
import 'package:shooppyy/views/widgets/checkout/shipping_address_state_item.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shipping Addresses'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<ShippingAddress>>(
            stream: database.getDefaultShippingAddress(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final shippingAddresses = snapshot.data;
                return Column(
                  children: shippingAddresses!
                      .map(
                        (e) => ShippingAddressStateItem(shippingAddress: e),
                      )
                      .toList(),
                );
              }
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.addShippingAddressPage,
              arguments: AddShippingAddressArgs(database: database));
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}
