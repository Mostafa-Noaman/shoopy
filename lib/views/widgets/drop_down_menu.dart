import 'package:flutter/material.dart';

class DropDownMenu extends StatelessWidget {
  const DropDownMenu(
      {super.key,
      required this.onSaved,
      required this.hint,
      required this.items});
  final void Function(String? value) onSaved;
  final String hint;
  final List items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      onSaved: onSaved,
      hint: Text(hint),
      borderRadius: BorderRadius.circular(5),
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 15,
      items: items.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {},
    );
  }
}
