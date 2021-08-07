import 'package:flutter/material.dart';
import 'package:water_reminder/view/home/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Water Reminder',
      home: HomeView(),
    );
  }
}
