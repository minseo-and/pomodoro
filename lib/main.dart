import 'package:flutter/material.dart';
import 'package:tomodoro/screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0xffe7626c),
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Color(0xff232b55)
          )
        ),
        cardColor: const Color(0xddd4eddb),
      ),
      home: HomeScreen(
      ),
    );
  }
}