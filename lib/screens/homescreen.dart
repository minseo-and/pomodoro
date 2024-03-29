import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  static const fiveMinuies = 300;
  int totalSeconds = twentyFiveMinutes;
  bool isRunning = false;
  bool isStudy = true;
  int totalPomodoros = 0;
  late Timer timer;

  void onTick(Timer timer) {
    if(totalSeconds == 0){
      setState(() {
        isRunning = false;
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text(isStudy ? '5분 휴식' : '공부할 시간'),
                actions: [
                  ElevatedButton
                  (
                    onPressed:(){
                      isStudy = !isStudy;
                      Navigator.of(context).pop();
                    },
                    child: Text('확인'))
                ],
              );
            });

        isStudy ? {totalSeconds = twentyFiveMinutes, totalPomodoros++} : totalSeconds = fiveMinuies;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  String format(int seconds){
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(isStudy ? '공부 할 시간' : '5분 휴식',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 20,
                    ),),
                    Text(
                      format(totalSeconds),
                      style: TextStyle(
                          color: Theme.of(context).cardColor,
                          fontSize: 89,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              )),
          Flexible(
              flex: 2,
              child: Center(
                child: IconButton(
                  iconSize: 120,
                  color: Theme.of(context).cardColor,
                  onPressed: isRunning ? onPausePressed
                    : onStartPressed,
                  icon: Icon(isRunning ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                ),
              )),
          Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '시간 관리',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color),
                            ),
                            Text(
                              '$totalPomodoros',
                              style: TextStyle(
                                  fontSize: 58,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .color),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );

  }
}
