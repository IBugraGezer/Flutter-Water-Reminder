import 'package:flutter/material.dart';
import 'package:water_reminder/view/home/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Water Reminder',
        home: HomeView(),
        theme: ThemeData(
            fontFamily: 'YanoneKaffeesatz-Regular',
            primaryColor: Color(0xff7C83FD),
            scaffoldBackgroundColor: Color(0xff7C83FD),
            textTheme: TextTheme(headline5: TextStyle(color: Colors.white))));
  }
}
