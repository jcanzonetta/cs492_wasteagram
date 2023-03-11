import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:wasteagram/models/food_waste_post.dart';

import '../widgets/food_waste_image.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'DetailScreen';

  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodWastePost post =
        ModalRoute.of(context)?.settings.arguments as FoodWastePost;

    return Scaffold(
      appBar: AppBar(title: const Text('Wasteagram')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(DateFormat.yMMMMEEEEd().format(post.date!)),
          ),
          FoodWasteImage(post: post),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Food wasted: ${post.quantity}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Location: (${post.latitude}, ${post.longitude})'),
          )
        ],
      ),
    );
  }
}
