import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/GetStartedClass.dart';
import 'package:tripfinder_app/Login.dart';
import 'package:tripfinder_app/Register.dart';

import 'firebase_options.dart';
import 'homaPage.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: GetStartedClass.routName,
      routes: {
        // GetStartedClass.routName:(BuildContext)=>GetStartedClass(),
        // Login.routName:(BuildContext)=>Login(),
        // Register.routName:(BuildContext)=>Register(),
        // HomePage.routName:(BuildContext)=>HomePage(),
        GetStartedClass.routName:(context)=>GetStartedClass(),
        Login.routName:(context)=>Login(),
        Register.routName:(context)=>Register(),
        HomePage.routName:(context)=>HomePage(),
      },

    );

  }
  
}
