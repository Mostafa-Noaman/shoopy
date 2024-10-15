import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shooppyy/controllers/checkout/checkout_cubit.dart';
import 'package:shooppyy/models/payment_method_model.dart';
import 'package:shooppyy/views/widgets/main_button.dart';

class AddNewCardBottomSheet extends StatefulWidget {
  const AddNewCardBottomSheet({super.key, this.paymentMethod});

  final PaymentMethod? paymentMethod;

  @override
  State<AddNewCardBottomSheet> createState() => _AddNewCardBottomSheetState();
}

class _AddNewCardBottomSheetState extends State<AddNewCardBottomSheet> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _nameCardController,
      _cardNumberController,
      _expireDateController,
      _cvvController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey();
    _nameCardController = TextEditingController();
    _cardNumberController = TextEditingController();
    _expireDateController = TextEditingController();
    _cvvController = TextEditingController();
    if (widget.paymentMethod != null) {
      _nameCardController.text = widget.paymentMethod!.name;
      _expireDateController.text = widget.paymentMethod!.expiryDate;
      _cardNumberController.text = widget.paymentMethod!.cardNumber;
      _cvvController.text = widget.paymentMethod!.cvv;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final checkOutCubit = BlocProvider.of<CheckoutCubit>(context);
    return SizedBox(
      height: size.height * 0.75,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text(
              'Add New Card',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _nameCardController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter card name'
                    : null,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: 'Name on Card',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _cardNumberController,
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter card number'
                    : null,
                onChanged: (value) {
                  String newValue = value.replaceAll('-', '');
                  if (newValue.length % 4 == 0 && newValue.length < 16) {
                    _cardNumberController.text += '-';
                  }
                  if (value.length >= 20) {
                    _cardNumberController.text = value.substring(0, 19);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _expireDateController,
                onChanged: (value) {
                  if (value.length == 2 && !value.contains('/')) {
                    _expireDateController.text += '/';
                  }
                  if (value.length == 6 && value.contains('/')) {
                    _expireDateController.text = value.substring(0, 5);
                  }
                },
                validator: (value) => value != null && value.isEmpty
                    ? 'Please enter expire date'
                    : null,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Expire Date',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _cvvController,
                onChanged: (value) {
                  if (value.length >= 3) {
                    _cvvController.text = value.substring(0, 3);
                  }
                },
                validator: (value) =>
                    value != null && value.isEmpty ? 'Please enter CVV' : null,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocConsumer<CheckoutCubit, CheckoutState>(
                bloc: checkOutCubit,
                listenWhen: (previous, current) =>
                    current is CardsAdded || current is CardsAddingFailed,
                listener: (context, state) {
                  if (state is CardsAdded) {
                    Navigator.of(context).pop();
                  } else if (state is CardsAddingFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    current is AddingCards ||
                    current is CardsAdded ||
                    current is CardsAddingFailed,
                builder: (context, state) {
                  if (state is AddingCards) {
                    return MainButton(
                      onTap: null,
                      child: const CircularProgressIndicator.adaptive(),
                    );
                  }
                  return MainButton(
                    text:
                        widget.paymentMethod != null ? 'Edit Card' : 'Add Card',
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        final paymentMethod = PaymentMethod(
                          id: widget.paymentMethod != null
                              ? widget.paymentMethod!.id
                              : DateTime.now().toIso8601String(),
                          name: _nameCardController.text,
                          cardNumber: _cardNumberController.text,
                          expiryDate: _expireDateController.text,
                          cvv: _cvvController.text,
                        );
                        await checkOutCubit.addCard(paymentMethod);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
