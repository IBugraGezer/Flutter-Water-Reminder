import 'package:flutter/material.dart';

AppBar topBar(BuildContext context) {
  return AppBar(
    title: Text(
      "Water Reminder",
      style: Theme.of(context).textTheme.headline5,
    ),
    backgroundColor: Theme.of(context).primaryColor,
    centerTitle: true,
  );
}
