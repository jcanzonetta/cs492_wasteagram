// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main() {
  test(
      'Post created from base contructor should have appropriate property values.',
      () {
    final date = DateTime.parse('2020-01-01');
    const url = 'Fake';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = 2.0;

    final foodWastePost = FoodWastePost(
        date: date,
        latitude: latitude,
        longitude: longitude,
        quantity: quantity,
        imageURL: url);

    expect(foodWastePost.date, date);
    expect(foodWastePost.imageURL, url);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });

  test('Post created with incorrect date data-type fails to construct.', () {
    Timestamp timestamp = Timestamp.now();
    const imageURL = 'Fake';
    const quantity = 1;
    const latitude = 10.0;
    const longitude = 5.0;

    final snapshot = {
      'date': timestamp,
      'imageURL': imageURL,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    };

    final foodWastePost = FoodWastePost.fromFirestore(snapshot);

    expect(foodWastePost.date, timestamp.toDate());
    expect(foodWastePost.imageURL, imageURL);
    expect(foodWastePost.quantity, quantity);
    expect(foodWastePost.latitude, latitude);
    expect(foodWastePost.longitude, longitude);
  });
}
