import 'dart:async';

import 'package:flutter/material.dart';
import 'package:water_reminder/utils/SharedPreferencesHelper.dart';
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
        await SharedPreferencesHelper.increaseTodayDrinks();
        drankWaterCounter =
            drankWaterCounter == null ? 0 : drankWaterCounter! + 1;

        checkIsGoalReached();

        setState(() {});

        controller.reset();
      }
    });

    setDrankWaterCounter();

    checkIsGoalReached();

    super.initState();
  }

  Future<void> setDrankWaterCounter() async {
    SharedPreferencesHelper.getLastDrinkWaterDate()
        .then((lastDrinkWaterDateAsMilliSeconds) async {
      DateTime lastDrinkWaterDate = DateTime.fromMillisecondsSinceEpoch(
          lastDrinkWaterDateAsMilliSeconds!);
      int differenceBetweenNowAndLastDrinkDate =
          DateTime.now().difference(lastDrinkWaterDate).inDays;

      if (differenceBetweenNowAndLastDrinkDate < 1) {
        this.drankWaterCounter =
            (await SharedPreferencesHelper.getTodayDrinks()) ?? 0;
        setState(() {});
      } else {
        SharedPreferencesHelper.resetTodayDrinks();
        SharedPreferencesHelper.setLastDrinkWaterDate(
            DateTime.now().millisecondsSinceEpoch);
        setState(() {
          this.drankWaterCounter = 0;
        });
      }
    });
  }

  Future<void> checkIsGoalReached() async {
    SharedPreferencesHelper.getTodayDrinks().then((todayDrinks) async {
      int? goal = await SharedPreferencesHelper.getGoal();
      if (goal != null && todayDrinks! >= goal) {
        setState(() {
          isGoalReached = true;
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
