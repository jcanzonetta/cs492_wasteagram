import 'package:flutter/material.dart';

import '../models/food_waste_post.dart';

class FoodWasteImage extends StatelessWidget {
  const FoodWasteImage({
    Key? key,
    required this.post,
  }) : super(key: key);

  final FoodWastePost post;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
