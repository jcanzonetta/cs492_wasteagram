import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/widgets/submit_button.dart';

import '../widgets/number_form_field.dart';

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
  void initState() {
    super.initState();
    initializeLocation();
  }

  void initializeLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();

    // Check if service is enabled.
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (!mounted) return;
        Navigator.of(context).pop();
      }
    }

    // Check if presmission is granted.
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (!mounted) return;
        Navigator.of(context)
            .pop("You need to grant Location permissions in order to post.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final File image = ModalRoute.of(context)!.settings.arguments as File;

    return Scaffold(
        appBar: AppBar(title: const Text('New Post')),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(image),
              ),
              NumberFormField(foodWastePostValues: foodWastePostValues),
              SubmitButton(
                  formKey: formKey,
                  image: image,
                  foodWastePostValues: foodWastePostValues),
            ],
          )),
        ));
  }
}
