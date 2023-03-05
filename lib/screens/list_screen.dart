import 'package:flutter/material.dart';
import '../widgets/posts_list.dart';

class ListScreen extends StatelessWidget {
  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram')),
      body: PostsList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.photo),
        onPressed: () {},
      ),
    );
  }
}
