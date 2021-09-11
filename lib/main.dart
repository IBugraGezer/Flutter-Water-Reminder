import 'dart:async';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:water_reminder/components/top_bar.dart';
import 'package:water_reminder/services/NotificationService.dart';
import 'package:water_reminder/utils/SharedPreferencesHelper.dart';
import 'package:water_reminder/view/home/home_view.dart';
import 'package:water_reminder/view/settings/settings_view.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
  NotificationService.sendNotification();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();
  await NotificationService.initialize();
  await SharedPreferencesHelper.init();
  await AndroidAlarmManager.periodic(
      const Duration(minutes: 2), helloAlarmID, printHello);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Water Reminder',
        home: PageLayout(pages: [HomeView(), Settings()]),
        theme: ThemeData(
            fontFamily: 'YanoneKaffeesatz-Regular',
            primaryColor: Color(0xff7C83FD),
            scaffoldBackgroundColor: Color(0xff7C83FD),
            textTheme: TextTheme(headline5: TextStyle(color: Colors.white))));
  }
}

class PageLayout extends StatefulWidget {
  const PageLayout({
    Key? key,
    required this.pages,
  }) : super(key: key);

  final pages;

  @override
  _PageLayoutState createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  int currentPageIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topBar(context),
      backgroundColor: Theme.of(context).primaryColor,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Made By Burra")],
        ),
      ),
      body: PageView(
        controller: pageController,
        children: widget.pages,
      ),
    );
  }
}
