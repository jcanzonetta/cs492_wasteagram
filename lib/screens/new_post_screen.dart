import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/widgets/submit_button.dart';

class NewPostScreen extends StatefulWidget {
  static const String routeName = 'NewPostScreen';

  NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  final foodWastePostValues = FoodWastePost();

  @override
  Widget build(BuildContext context) {
    final File image = ModalRoute.of(context)!.settings.arguments as File;

    Widget newPostImage() {
      if (image == null) {
        return const Text('Select an image');
      } else {
        return Image.file(image!);
      }
    }

    return Scaffold(
        appBar: AppBar(title: const Text('New Post')),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newPostImage(),
              TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              SubmitButton(
                  formKey: formKey,
                  image: image,
                  foodWastePostValues: foodWastePostValues),
            ],
          )),
        ));
  }
}
