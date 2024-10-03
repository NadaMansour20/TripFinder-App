import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/flight_ticket.dart';


class FlightTicket extends StatelessWidget {
  FlightTicket({super.key, required this.fligthTicketModel});
  final FligthTicketModel fligthTicketModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 300,



      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(

        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],

      ),
      child: Column(
        children: [
          // Flight Route (NYC -> SFO)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fligthTicketModel.namedeparture!, //NYC
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    truncateText(fligthTicketModel.namedeparturelong! , 10),
                    //fligthTicketModel.namedeparturelong!,//New York
                    style: TextStyle(color: Colors.grey,fontSize: 14)
                    ,
                  ),
                ],
              ),
              Icon(Icons.flight_takeoff, color: Colors.blue),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,//
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    fligthTicketModel.namearrive!, //SFO
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    truncateText(fligthTicketModel.namearrivelong! , 10),
                    // fligthTicketModel.namearrivelong!, //San Francisco
                    style: TextStyle(color: Colors.grey,fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          // Flight Duration
          // Text(
          //   '6H 30M',
          //   style: TextStyle(
          //     fontSize: 16,
          //     color: Colors.black54,
          //   ),
          // ),black54
          SizedBox(height: 20),
          Divider(color: Colors.grey[300]),
          // Flight Details (Time, Date, Flight Number)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    truncateText(fligthTicketModel.timedeparture! , 10),
                    // fligthTicketModel.timedeparture!,//08:00 AM
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    'Departure date',
                    style: TextStyle(color: Colors.grey,fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,//end
                children: [
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    truncateText(fligthTicketModel.timearrive! , 10),
                    //  fligthTicketModel.timearrive!,//'02:30 PM'
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    'Arrival date',
                    style: TextStyle(color: Colors.grey,fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Divider(color: Colors.grey[300]),
          // Airline and Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 20,
                    child: Icon(
                      Icons.airplanemode_active,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Price',
                    style: TextStyle(fontSize: 18),

                  ),
                ],
              ),
              Text(
                "\$${fligthTicketModel.price.toString()}", //\$260
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
String truncateText(String text, int maxLength) {
  return (text.length > maxLength) ? '${text.substring(0, maxLength)}...' : text;
}