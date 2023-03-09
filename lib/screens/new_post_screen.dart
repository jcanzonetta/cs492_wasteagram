import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class NewPostScreen extends StatefulWidget {
  static const String routeName = 'NewPostScreen';

  NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  final formKey = GlobalKey<FormState>();
  final foodWastePostValues = FoodWastePost();
  bool _uploadingPost = false;

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
                    foodWastePostValues.number = int.parse(newValue!);
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
              ElevatedButton.icon(
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? true) {
                    setState(() {
                      _uploadingPost = true;
                    });

                    formKey.currentState!.save();

                    // Get today's date and save it to the entry
                    foodWastePostValues.date = DateTime.now();

                    // Upload image to Firestore
                    String fileName = '${foodWastePostValues.date}.jpg';
                    Reference storageReference =
                        FirebaseStorage.instance.ref().child(fileName);

                    UploadTask uploadTask = storageReference.putFile(image!);
                    await uploadTask;

                    // Receive url of photo and add it to the entry
                    var photoUrl = await storageReference.getDownloadURL();
                    foodWastePostValues.photoURL = photoUrl;

                    // Get the lat and long and save it to the entry
                    var locationService = Location();
                    var locationData = await locationService.getLocation();
                    foodWastePostValues.lat = locationData.latitude;
                    foodWastePostValues.long = locationData.longitude;

                    // Save the entry to Firestore
                    DocumentReference result = await FirebaseFirestore.instance
                        .collection('posts')
                        .add({
                      'date': foodWastePostValues.date,
                      'lat': foodWastePostValues.lat,
                      'long': foodWastePostValues.long,
                      'number': foodWastePostValues.number,
                      'photoURL': foodWastePostValues.photoURL
                    });

                    // Return to previous screen
                    if (!mounted) return;
                    Navigator.of(context).pop();
                  }
                },
                icon: _uploadingPost
                    ? Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(
                            color: Colors.white),
                      )
                    : Container(
                        padding: EdgeInsets.all(2.0),
                        child: const Icon(Icons.cloud_circle)),
                label: const Text('Upload'),
              )
            ],
          )),
        ));
  }
}
