import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePost {
  DateTime date;
  double lat;
  double long;
  int number;
  String photoURL;

  FoodWastePost(
      {required this.date,
      required this.lat,
      required this.long,
      required this.number,
      required this.photoURL});

  factory FoodWastePost.fromFirestore(QueryDocumentSnapshot<Object?> post) {
    return FoodWastePost(
        date: post['date'].toDate(),
        lat: post['lat'],
        long: post['long'],
        number: post['number'],
        photoURL: post['photoURL']);
  }
}
