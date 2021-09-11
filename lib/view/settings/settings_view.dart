import 'package:flutter/material.dart';
import 'package:water_reminder/services/sharedpreferences_service.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController goalCounterController = TextEditingController();
  int goalCounterValue = 3;
  int goalCounterMinValue = 3;
  int goalCounterMaxMalue = 15;

  @override
  void initState() {
    super.initState();
    int? goal = SharedPreferencesService.getGoal();
    setState(() {
      this.goalCounterValue = goal ?? 0;

      goalCounterController.text = this.goalCounterValue.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          goalTitle(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              goalIncreaseButton(),
              goalText(deviceSize, context),
              goalDecreaseButton(),
            ],
          )
        ],
      ),
    );
  }

  Text goalTitle(BuildContext context) {
    return Text(
      "Daily Goal",
      style:
          Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),
    );
  }

  Container goalText(Size deviceSize, BuildContext context) {
    return Container(
        width: deviceSize.width * 0.50,
        child: TextField(
            controller: goalCounterController,
            enabled: false,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6));
  }

  IconButton goalDecreaseButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (goalCounterValue > goalCounterMinValue) {
            goalCounterValue -= 1;
            setGoal();
            goalCounterController.text = goalCounterValue.toString();
          }
        });
      },
      icon: Icon(Icons.remove),
    );
  }

  IconButton goalIncreaseButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (goalCounterValue < goalCounterMaxMalue) {
            goalCounterValue += 1;
            setGoal();
            goalCounterController.text = goalCounterValue.toString();
          }
        });
      },
      icon: Icon(Icons.add),
    );
  }

  void setGoal() {
    SharedPreferencesService.setGoal(goalCounterValue);
  }
}
