import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/flight_ticket.dart';
import '../services/flight_service.dart';
import 'flight_card.dart';

class FlightTicketList extends StatefulWidget {
  @override
  State<FlightTicketList> createState() => _FlightTicketListState();
}

class _FlightTicketListState extends State<FlightTicketList> {
  List<FligthTicketModel> tickets=[];
  bool isloading= true;

  void initState() {
    super.initState();
    getTickets();

  }

  Future<void> getTickets() async {
    tickets =await NewServiceFlight(Dio()).getTicket();
    isloading=false;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return isloading ? Center(child: CircularProgressIndicator()): ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context,index){
          return
            Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: FlightTicket(fligthTicketModel: tickets[index],),
              ),

            );
        });



  }}