import 'dart:async';

import 'package:flutter/material.dart';
import 'package:water_reminder/view/home/components/counter.dart';
import 'package:water_reminder/components/top_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  double progress = 0;
  double time = 3;
  double currentTime = 3;

  int drankWaterCounter = 5;

  late Timer timer;
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          drankWaterCounter += 1;
        });
        controller.reset();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                drankCounterText(context),
              ],
            ),
            GestureDetector(
              onTapDown: (_) {
                controller.forward();
              },
              onTapUp: (_) {
                if (controller.status == AnimationStatus.forward) {
                  controller.reverse();
                }
              },
              child: Glass(
                screenSize: screenSize,
                progress: progress,
                animationController: this.controller,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Text drankCounterText(BuildContext context) {
    return Text(
      "You drank " + drankWaterCounter.toString() + " glasses of water today",
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
