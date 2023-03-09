import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasteagram/models/food_waste_post.dart';
import 'package:wasteagram/screens/detail_screen.dart';

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
              FoodWastePost post =
                  FoodWastePost.fromFirestore(snapshot.data!.docs[index]);
              return Card(
                child: ListTile(
                  title: Text(DateFormat.yMMMMEEEEd().format(post.date!)),
                  trailing: Text(post.number.toString()),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(DetailScreen.routeName, arguments: post);
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// String formatTimeStamp(Timestamp timestamp) {var format = DateFormat()}
