import 'package:flutter/material.dart';

class Glass extends StatefulWidget {
  const Glass({
    Key? key,
    required this.screenSize,
    required this.progress,
    required this.animationController,
  }) : super(key: key);

  final Size screenSize;
  final double progress;
  final AnimationController animationController;

  @override
  _CounterState createState() =>
      _CounterState(animationController: animationController);
}

class _CounterState extends State<Glass> {
  var animationController;

  _CounterState({required this.animationController});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red,
          ),
          child: Image(
            image: AssetImage("assets/images/water-glass.png"),
            width: widget.screenSize.width / 1.5,
          ),
        ),
        Container(
          width: widget.screenSize.width / 1.5,
          height: widget.screenSize.width / 1.5,
          child: CircularProgressIndicator(
            value: animationController.value,
            strokeWidth: 10,
          ),
        ),
      ],
    );
  }
}
