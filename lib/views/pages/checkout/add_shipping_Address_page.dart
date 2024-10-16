import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/checkout/checkout_cubit.dart';
import 'package:shooppyy/models/shipping_address.dart';
import 'package:shooppyy/utilities/constants.dart';
import 'package:shooppyy/views/widgets/main_button.dart';
import 'package:shooppyy/views/widgets/main_dialog.dart';

class AddShippingAddressPage extends StatefulWidget {
  const AddShippingAddressPage({super.key, this.shippingAddress});

  final ShippingAddress? shippingAddress;

  @override
  State<AddShippingAddressPage> createState() => _AddShippingAddressPageState();
}

class _AddShippingAddressPageState extends State<AddShippingAddressPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _fulNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _countryController = TextEditingController();
  ShippingAddress? shippingAddress;

  @override
  void initState() {
    super.initState();
    shippingAddress = widget.shippingAddress;
    if (shippingAddress != null) {
      _fulNameController.text = shippingAddress!.fullName;
      _addressController.text = shippingAddress!.address;
      _cityController.text = shippingAddress!.city;
      _stateController.text = shippingAddress!.state;
      _zipCodeController.text = shippingAddress!.zipCode;
      _countryController.text = shippingAddress!.country;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _fulNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
  }

  Future<void> saveAddress(CheckoutCubit checkoutCubit) async {
    try {
      if (_formKey.currentState!.validate()) {
        final address = ShippingAddress(
          id: shippingAddress != null
              ? shippingAddress!.id
              : documentIdFromLocalData(),
          fullName: _fulNameController.text.trim(),
          country: _countryController.text.trim(),
          address: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          zipCode: _zipCodeController.text.trim(),
        );
        await checkoutCubit.saveAddress(address);
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    } catch (e) {
      MainDialog(
        context: context,
        title: 'Error!',
        content: e.toString(),
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(shippingAddress != null
            ? 'Editing shipping Address'
            : 'Adding shipping Address'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _fulNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your name',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your address',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _cityController,
                  decoration: const InputDecoration(
                    labelText: 'City',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your city',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _stateController,
                  decoration: const InputDecoration(
                    labelText: 'State/Province',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your state',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _zipCodeController,
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your zip code',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: 'Country',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  validator: (value) =>
                      value!.isNotEmpty ? null : 'Please enter your country',
                ),
                const SizedBox(height: 24),
                MainButton(
                  text: 'Save Address',
                  onTap: () {
                    saveAddress(checkoutCubit);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
