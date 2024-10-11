import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/flight_ticket.dart';

class FlightTicket extends StatefulWidget {
  FlightTicket({super.key, required this.fligthTicketModel});
  final FligthTicketModel fligthTicketModel;

  @override
  State<FlightTicket> createState() => _FlightTicketState();
}

class _FlightTicketState extends State<FlightTicket> {
  Future<void> saveFlightTicket() async {
    // Get the current user ID
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      final flightData = {
        'departure': widget.fligthTicketModel.namedeparture,
        'arrival': widget.fligthTicketModel.namearrive,
        'duration': widget.fligthTicketModel.duration,
        'price': widget.fligthTicketModel.price,
        'departureTime': widget.fligthTicketModel.timedeparture,
        'arrivalTime': widget.fligthTicketModel.timearrive,
        'departureCity': widget.fligthTicketModel.airportModel!.namecitydeparture,
        'arrivalCity': widget.fligthTicketModel.airportModel!.namecityarrive,
      };

      try {
        await userDoc.collection('flights').add(flightData); // Save flight data under the user's flight collection
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Flight ticket saved successfully!")),
        );

      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save flight ticket")),
        );

      }
    } else {
      print("No user is signed in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // First card
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.0),
                        ),
                        child: Image.network(
                          widget.fligthTicketModel.airportModel!.imageCountrydeparture!,
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.fligthTicketModel.airportModel!.nameCountrydeparture!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City name= ${widget.fligthTicketModel.airportModel!.namecitydeparture}.\nduration= ${(widget.fligthTicketModel.duration).toString()} minutes.',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),

              // Second card
              Expanded(
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.0),
                        ),
                        child: Image.network(
                          widget.fligthTicketModel.airportModel!.imageCountryarrive!,
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.fligthTicketModel.airportModel!.nameCountryarrive!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City name= ${widget.fligthTicketModel.airportModel!.namecityarrive!}.\nduration= ${(widget.fligthTicketModel.duration).toString()} minutes.',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: 350,
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
                // Flight Route
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fligthTicketModel.namedeparture!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          truncateText(widget.fligthTicketModel.namedeparturelong!, 10),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Icon(Icons.flight_takeoff, color: Colors.blue),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fligthTicketModel.namearrive!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          truncateText(widget.fligthTicketModel.namearrivelong!, 10),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[300]),
                // Flight Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          truncateText(widget.fligthTicketModel.timedeparture!, 10),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Departure date',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          truncateText(widget.fligthTicketModel.timearrive!, 10),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Arrival date',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
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
                      "\$${widget.fligthTicketModel.price.toString()}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Book Now Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFC1E3),
                          Color(0xFFBA68C8),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Save the flight ticket information when the button is pressed
                        saveFlightTicket();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String truncateText(String text, int maxLength) {
    if (text.length > maxLength) {
      return text.substring(0, maxLength) + '...';
    }
    return text;
  }
}