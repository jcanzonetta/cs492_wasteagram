import 'package:flutter/material.dart';

import 'screens/detail_screen.dart';
import 'screens/new_post_screen.dart';
import 'screens/list_screen.dart';

class App extends StatelessWidget {
  static final routes = {
    ListScreen.routeName: (context) => ListScreen(),
    NewPostScreen.routeName: (context) => NewPostScreen(),
    DetailScreen.routeName: (context) => const DetailScreen()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: App.routes,
    );
  }
}
