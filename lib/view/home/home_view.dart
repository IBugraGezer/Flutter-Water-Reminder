import 'dart:async';

import 'package:flutter/material.dart';
import 'package:water_reminder/services/sharedpreferences_service.dart';
import 'package:water_reminder/view/home/components/counter.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  double progress = 0;
  double time = 3;
  double currentTime = 3;

  bool isGoalReached = false;

  int? drankWaterCounter;

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

    controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await SharedPreferencesService.increaseTodayDrinks();
        drankWaterCounter =
            drankWaterCounter == null ? 0 : drankWaterCounter! + 1;

        isGoalReached = SharedPreferencesService.isGoalReached();

        setState(() {});

        controller.reset();
      }
    });

    setDrankWaterCounter();

    setState(() {
      isGoalReached = SharedPreferencesService.isGoalReached();
    });

    super.initState();
  }

  Future<void> setDrankWaterCounter() async {
    SharedPreferencesService.getLastDrinkWaterDate()
        .then((lastDrinkWaterDateAsMilliSeconds) async {
      DateTime lastDrinkWaterDate = DateTime.fromMillisecondsSinceEpoch(
          lastDrinkWaterDateAsMilliSeconds!);
      int differenceBetweenNowAndLastDrinkDate =
          DateTime.now().difference(lastDrinkWaterDate).inDays;

      if (differenceBetweenNowAndLastDrinkDate < 1) {
        this.drankWaterCounter = SharedPreferencesService.getTodayDrinks() ?? 0;
        setState(() {});
      } else {
        SharedPreferencesService.resetTodayDrinks();
        SharedPreferencesService.setLastDrinkWaterDate(
            DateTime.now().millisecondsSinceEpoch);
        setState(() {
          this.drankWaterCounter = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          child: drankCounterText(context),
        ),
        Spacer(flex: 1),
        if (isGoalReached)
          Text(
            "Congratulations! You reached the daily goal!",
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.greenAccent),
          ),
        Spacer(
          flex: 2,
        ),
        GestureDetector(
          onTapDown: (_) {
            controller.forward();
          },
          onTapCancel: () {
            if (controller.status == AnimationStatus.forward) {
              controller.reverse();
            }
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
        Spacer()
      ],
    ));
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Text drankCounterText(BuildContext context) {
    return Text(
      "You drank " +
          (drankWaterCounter ?? 0).toString() +
          " glasses of water today",
      style: Theme.of(context).textTheme.headline6,
    );
  }
}
