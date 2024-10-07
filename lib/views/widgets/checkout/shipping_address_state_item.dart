import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shooppyy/utilities/args_model/add_shipping_address_args.dart';
import '../../../controllers/database_controller.dart';
import '../../../models/shipping_address.dart';
import '../../../utilities/routes.dart';

class ShippingAddressStateItem extends StatefulWidget {
  const ShippingAddressStateItem({super.key, required this.shippingAddress});

  final ShippingAddress shippingAddress;

  @override
  State<ShippingAddressStateItem> createState() =>
      _ShippingAddressStateItemState();
}

class _ShippingAddressStateItemState extends State<ShippingAddressStateItem> {
  late bool checkedValue;

  @override
  void initState() {
    super.initState();
    checkedValue = widget.shippingAddress.isDefault;
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.shippingAddress.fullName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.addShippingAddressPage,
                      arguments: AddShippingAddressArgs(
                        database: database,
                        shippingAddress: widget.shippingAddress,
                      ),
                    );
                  },
                  child: Text(
                    'Edit',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.shippingAddress.address,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${widget.shippingAddress.city},${widget.shippingAddress.state},${widget.shippingAddress.country}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            CheckboxListTile(
              value: checkedValue,
              onChanged: (value) async {
                setState(() {
                  checkedValue = value!;
                });
                final newAddress =
                    widget.shippingAddress.copyWith(isDefault: value);
                await database.saveAddress(newAddress);
              },
              title: const Text('Default shipping address'),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
