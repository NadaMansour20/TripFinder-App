import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  static const String routName = "homepage";
  const HomePage({Key? key}):super(key: key);
  @override
 Widget build (BuildContext context){
   return Scaffold(
     body: Text('homepage'),
   );
 }

}