import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';
import 'package:tripfinder_app/CustomWidgets/HotelDetails.dart';
import 'package:tripfinder_app/GetStartedClass.dart';
import 'package:tripfinder_app/Login.dart';
import 'package:tripfinder_app/MainScreen.dart';
import 'package:tripfinder_app/NewWidgetOfLocations.dart';
import 'package:tripfinder_app/Register.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: GetStartedClass.routName,
      initialRoute: MainScreen.routName,

      routes: {
        GetStartedClass.routName:(BuildContext)=>GetStartedClass(),
        Login.routName:(BuildContext)=>Login(),
        Register.routName:(BuildContext)=>Register(),
        MainScreen.routName:(BuildContext)=>MainScreen(),
        HotelDetails.routName: (context) => HotelDetails(ModalRoute.of(context)!.settings.arguments as Properties), // تمرير الفندق كمعامل
      },

    );

  }
  
}
