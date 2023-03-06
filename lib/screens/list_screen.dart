import 'dart:io';

import 'package:flutter/material.dart';
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
    // Get image from device.
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    image = File(pickedImage!.path);

    if (!mounted) return;
    Navigator.of(context).pushNamed(NewPostScreen.routeName, arguments: image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram')),
      body: PostsList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.photo),
        onPressed: () async {
          getImage();
        },
      ),
    );
  }
}
