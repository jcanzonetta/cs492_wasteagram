import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/food_waste_post.dart';

class NumberFormField extends StatelessWidget {
  const NumberFormField({
    Key? key,
    required this.foodWastePostValues,
  }) : super(key: key);

  final FoodWastePost foodWastePostValues;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          maxLength: 3,
          decoration: const InputDecoration(
              labelText: 'Number of Wasted Items',
              border: OutlineInputBorder()),
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
    );
  }
}
