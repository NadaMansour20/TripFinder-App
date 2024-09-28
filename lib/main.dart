import 'package:flutter/material.dart';
import 'package:triv_intro/homeScreen.dart';
import 'package:triv_intro/onBoarding.dart';
import 'package:triv_intro/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: onBoarding(),
      theme: ThemeData(

      ),
    );
  }
}

