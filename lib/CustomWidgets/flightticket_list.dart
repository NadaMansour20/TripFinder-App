import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:tripfinder_app/models/flight_ticket.dart'; // Your actual path
import 'package:tripfinder_app/services/flight_service.dart'; // Your actual path
import 'flight_card.dart';// Your actual path

class FlightTicketList extends StatefulWidget {
  final String departureCityCode;
  final String arrivalCityCode;

  FlightTicketList({required this.departureCityCode, required this.arrivalCityCode});


  @override
  _FlightTicketListState createState() => _FlightTicketListState();
}

class _FlightTicketListState extends State<FlightTicketList> {
  List<FligthTicketModel> tickets = [];
  bool isLoading = true;



  @override
  void initState() {
    super.initState();
    getTickets();
  }

  Future<void> getTickets() async {
    // Pass the city codes to the API request
    tickets = await NewServiceFlight(Dio()).getspecialTicket(
      departureid: widget.departureCityCode, // Use passed departure city code
      arrivalidid: widget.arrivalCityCode,   // Use passed arrival city code
      // from: "2024-10-02", // Static for now, you can make it dynamic later
      // to: "2024-10-03",   // Static for now, you can make it dynamic later
    );
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Tickets available",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: tickets.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: FlightTicket(fligthTicketModel: tickets[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}