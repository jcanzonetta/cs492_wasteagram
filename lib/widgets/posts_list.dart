import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/food_waste_post.dart';
import 'post_card.dart';

class PostsList extends StatefulWidget {
  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .orderBy("date", descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              FoodWastePost post = FoodWastePost.fromFirestore(
                  snapshot.data!.docs[index].data() as Map);

              return PostCard(post: post);
            },
          );
        } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Center(child: Text("No one has posted anything yet.")),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
