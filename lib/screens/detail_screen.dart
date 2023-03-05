import 'package:flutter/material.dart';
import 'package:wasteagram/app.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = 'DetailScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Screen')),
    );
  }
}
