import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'CustomWidgets/flightticket_list.dart';

class HomePage extends StatelessWidget{
  static const String routName = "homepage";
  const HomePage({Key? key}):super(key: key);
  @override
 Widget build (BuildContext context){
   return (
       Scaffold(
         body: Column(
           children: [
             Expanded(child: FlightTicketList()),
           ],
         )

   ));
 }

}