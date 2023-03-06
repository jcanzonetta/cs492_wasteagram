import 'package:cloud_firestore/cloud_firestore.dart';

class FoodWastePost {
  DateTime? date;
  double? lat;
  double? long;
  int? number;
  String? photoURL;

  FoodWastePost({this.date, this.lat, this.long, this.number, this.photoURL});

  factory FoodWastePost.fromFirestore(QueryDocumentSnapshot<Object?> post) {
    return FoodWastePost(
        date: post['date'].toDate(),
        lat: post['lat'],
        long: post['long'],
        number: post['number'],
        photoURL: post['photoURL']);
  }
}
