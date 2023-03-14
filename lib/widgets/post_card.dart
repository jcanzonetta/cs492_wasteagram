import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/food_waste_post.dart';
import '../screens/detail_screen.dart';

class PostCard extends StatelessWidget {
  final FoodWastePost post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Semantics(
        label: 'A card for a Wasteagram post with date and number of '
            'wasted items.',
        onTapHint: 'Shows details for the selected post.',
        child: ListTile(
          title: Text(DateFormat.yMMMMEEEEd().format(post.date!)),
          trailing: Text(post.quantity.toString()),
          onTap: () {
            Navigator.of(context)
                .pushNamed(DetailScreen.routeName, arguments: post);
          },
        ),
      ),
    );
  }
}
