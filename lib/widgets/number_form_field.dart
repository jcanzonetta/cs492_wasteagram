import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/food_waste_post.dart';

class NumberFormField extends StatelessWidget {
  const NumberFormField({
    Key? key,
    required this.foodWastePostValues,
  }) : super(key: key);

  static const formLabel = "Number of Wasted Items";
  final FoodWastePost foodWastePostValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Semantics(
        textField: true,
        hint: 'The number of wasted items in the photo must be more than 0 and '
            'less than 1000.',
        label: 'Required: $formLabel',
        child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            maxLength: 3,
            decoration: const InputDecoration(
                labelText: formLabel, border: OutlineInputBorder()),
            onSaved: (newValue) {
              foodWastePostValues.quantity = int.parse(newValue!);
            },
            validator: (newValue) {
              if (newValue?.isEmpty ?? true) {
                return 'Please enter the number of food items wated.';
              } else if (int.parse(newValue!) <= 0) {
                return 'The number of itmes wasted must be greater than 0.';
              } else {
                return null;
              }
            }),
      ),
    );
  }
}
