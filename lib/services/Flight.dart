import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/CustomWidgets/flightticket_list.dart';



class Flight extends StatelessWidget{
  static const String routName = "Flight";
  const Flight({Key? key}):super(key: key);
  @override
  Widget build (BuildContext context){
    return (
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Center(
                child: Text(
                  "Book your Tickets",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              //leading: Icon(Icons.arrow_back),
            ),

            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "     From",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "To      ",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),


                Expanded(child: FlightTicketList()),
              ],
            )

        ));
  }

}