import 'dart:async';
import 'package:flutter/material.dart';

class SignupTimer extends StatefulWidget {
  const SignupTimer({super.key});

  @override
  State<SignupTimer> createState() => _SignupTimerState();
}

class _SignupTimerState extends State<SignupTimer> {
  DateTime endTime = DateTime.now().add(Duration(minutes: 5, seconds: 00));

  @override
  Widget build(BuildContext context) {
    Duration timeRemaining = endTime.difference(DateTime.now());

    int minutes = timeRemaining.inMinutes;
    int seconds = timeRemaining.inSeconds % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$minutes:$seconds',
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    // 매 초마다 화면을 갱신하기 위한 타이머 설정
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }
}
