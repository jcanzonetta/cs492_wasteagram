import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:location/location.dart';
import '../models/food_waste_post.dart';

class SubmitButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final FoodWastePost foodWastePostValues;
  final File image;

  const SubmitButton(
      {super.key,
      required this.formKey,
      required this.foodWastePostValues,
      required this.image});

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  bool _uploadingPost = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (_uploadingPost) {
            return;
          }

          if (widget.formKey.currentState?.validate() ?? true) {
            setState(() {
              _uploadingPost = true;
            });

            widget.formKey.currentState!.save();

            // Get today's date and save it to the entry
            widget.foodWastePostValues.date = DateTime.now();

            // Upload image to Firestore
            String fileName = '${widget.foodWastePostValues.date}.jpg';
            Reference storageReference =
                FirebaseStorage.instance.ref().child(fileName);

            UploadTask uploadTask = storageReference.putFile(widget.image);
            await uploadTask;

            // Receive url of photo and add it to the entry
            var photoUrl = await storageReference.getDownloadURL();
            widget.foodWastePostValues.imageURL = photoUrl;

            // Get the lat and long and save it to the entry
            var locationService = Location();
            var locationData = await locationService.getLocation();
            widget.foodWastePostValues.latitude = locationData.latitude;
            widget.foodWastePostValues.longitude = locationData.longitude;

            // Save the entry to Firestore
            FirebaseFirestore.instance.collection('posts').add({
              'date': widget.foodWastePostValues.date,
              'latitude': widget.foodWastePostValues.latitude,
              'longitude': widget.foodWastePostValues.longitude,
              'quantity': widget.foodWastePostValues.quantity,
              'imageURL': widget.foodWastePostValues.imageURL
            });

            // Return to previous screen
            if (!mounted) return;
            Navigator.of(context).pop();
          }
        },
        icon: _uploadingPost
            ? Transform.scale(
                scale: 0.5,
                child: const CircularProgressIndicator(color: Colors.white),
              )
            : Container(
                padding: const EdgeInsets.all(2.0),
                child: const Icon(Icons.cloud_circle)),
        label: const Text('Upload'),
      ),
    );
  }
}
