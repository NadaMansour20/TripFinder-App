import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tripfinder_app/Ui/OnBoarding.dart';


class Welcomepage extends StatefulWidget {

  static const String routName="welcome";

  const Welcomepage({super.key});


  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>onBoarding(),
        ),
      ); // Navigate to your home screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Image.asset('assets/images/splash.png',fit:BoxFit.fill,)),
        ],
      ),
    );
  }
}