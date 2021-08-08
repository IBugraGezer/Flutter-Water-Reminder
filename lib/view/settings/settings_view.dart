import 'package:flutter/material.dart';
import 'package:water_reminder/utils/SharedPreferencesHelper.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController goalCounterController = TextEditingController();
  int goalCounterValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferencesHelper.getGoal().then((value) {
      print(value);
      setState(() {
        this.goalCounterValue = value!;

        goalCounterController.text = value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Daily Goal",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.black),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    goalCounterValue += 1;
                    setGoal();
                    goalCounterController.text = goalCounterValue.toString();
                  });
                },
                icon: Icon(Icons.add),
              ),
              Container(
                  width: deviceSize.width * 0.50,
                  child: TextField(
                      controller: goalCounterController,
                      enabled: false,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6)),
              IconButton(
                onPressed: () {
                  setState(() {
                    goalCounterValue -= 1;
                    setGoal();
                    goalCounterController.text = goalCounterValue.toString();
                  });
                },
                icon: Icon(Icons.remove),
              ),
            ],
          )
        ],
      ),
    );
  }

  void setGoal() {
    SharedPreferencesHelper.setGoal(goalCounterValue);
  }
}
