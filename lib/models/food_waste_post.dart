class FoodWastePost {
  DateTime? date;
  double? latitude;
  double? longitude;
  int? quantity;
  String? imageURL;

  FoodWastePost(
      {this.date, this.latitude, this.longitude, this.quantity, this.imageURL});

  factory FoodWastePost.fromFirestore(Map post) {
    return FoodWastePost(
        date: post['date'].toDate(),
        latitude: post['latitude'],
        longitude: post['longitude'],
        quantity: post['quantity'],
        imageURL: post['imageURL']);
  }
}
