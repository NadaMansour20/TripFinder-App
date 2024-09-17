import 'package:flutter/material.dart';
import 'package:tripfinder_app/GetStartedClass.dart';
import 'package:tripfinder_app/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: GetStartedClass.routName,
      routes: {
        GetStartedClass.routName:(BuildContext)=>GetStartedClass(),
        Login.routName:(BuildContext)=>Login(),
      },

    );

  }
  
}
