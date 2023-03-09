import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:wasteagram/models/food_waste_post.dart';

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              post.imageURL!,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null),
                  );
                }
              },
            ),
          ),
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
