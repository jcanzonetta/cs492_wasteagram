import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wasteagram/screens/new_post_screen.dart';
import '../widgets/posts_list.dart';

class ListScreen extends StatefulWidget {
  static const String routeName = '/';

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  File? image;

  void getImage() async {
    try {
      // Get image from device.
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage == null) return;

      image = File(pickedImage.path);
    } on PlatformException catch (error) {
      print('Unable to get image: $error');
    }

    if (!mounted) return;
    final result = await Navigator.pushNamed(context, NewPostScreen.routeName,
        arguments: image);

    if (result == null) return;
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(result as String)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('posts').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              num totalWasted = 0;
              if (snapshot.hasData) {
                for (var post in snapshot.data!.docs) {
                  totalWasted += post['quantity'];
                }
                return Text('Wasteagram - $totalWasted');
              } else {
                return const Text('Wasteagram - Loading...');
              }
            }),
      ),
      body: PostsList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.photo),
        onPressed: () async {
          getImage();
        },
      ),
    );
  }
}
