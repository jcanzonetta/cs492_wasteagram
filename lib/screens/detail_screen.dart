import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/app.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'DetailScreen';
  @override
  Widget build(BuildContext context) {
    final FoodWastePost post =
        ModalRoute.of(context)?.settings.arguments as FoodWastePost;

    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram')),
      body: Column(
        children: [
          Text(DateFormat.yMMMMEEEEd().format(post.date)),
          const Placeholder(),
          Text(post.number.toString()),
          Text('Location: (${post.lat}, ${post.long})')
        ],
      ),
    );
  }
}
