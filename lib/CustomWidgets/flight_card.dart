import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/flight_ticket.dart';
import 'CustomButton.dart';


class FlightTicket extends StatelessWidget {
  FlightTicket({super.key, required this.fligthTicketModel});

  final FligthTicketModel fligthTicketModel;

  CollectionReference userLoginData = FirebaseFirestore.instance.collection('userLoginData/userid/flights');
  bool _isButtonDisabled = false;

  void _handleButtonClick() {
    print('Button clicked!');
addFlights();
      _isButtonDisabled = true;
  }
  Future<void> addFlights() {
    return userLoginData
        .add({
    'nameCountrydeparture': fligthTicketModel.airportModel!.nameCountrydeparture,
    'imageCountrydeparture': fligthTicketModel.airportModel!.imageCountrydeparture,
    'namecitydeparture': fligthTicketModel.airportModel!.namecitydeparture,
    'namecityarrive': fligthTicketModel.airportModel!.namecityarrive,
    'nameCountryarrive': fligthTicketModel.airportModel!.nameCountryarrive,
    'imageCountryarrive': fligthTicketModel.airportModel!.imageCountryarrive,
    'savedAt': Timestamp.now(),
    'price':fligthTicketModel.price


    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align the cards with space in between
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
                          fligthTicketModel.airportModel!.imageCountrydeparture!, // Replace with your asset image path
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
                              fligthTicketModel.airportModel!.nameCountrydeparture!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City name= ${fligthTicketModel.airportModel!.namecitydeparture}.\nduration= ${(fligthTicketModel.duration).toString()} minutes.',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16), // Spacing between the two cards

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
                          fligthTicketModel.airportModel!.imageCountryarrive!, // Replace with your asset image path
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

                              fligthTicketModel.airportModel!.nameCountryarrive!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City name= ${fligthTicketModel.airportModel!.namecityarrive!}.\nduration= ${(fligthTicketModel.duration).toString()} minutes.',
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
            //height: 320,
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
                          fligthTicketModel.namedeparture!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          truncateText(fligthTicketModel.namedeparturelong!, 10),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Icon(Icons.flight_takeoff, color: Colors.blue),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fligthTicketModel.namearrive!,
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          truncateText(fligthTicketModel.namearrivelong!, 10),
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Divider(color: Colors.grey[300]),
                // Flight Details (Time, Date, Flight Number)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          truncateText(fligthTicketModel.timedeparture!, 10),
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
                          truncateText(fligthTicketModel.timearrive!, 10),
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
                      "\$${fligthTicketModel.price.toString()}",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20), // Add space before the button
                // Book Now Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFFFC1E3), // لون وردي فاتح
                          Color(0xFFBA68C8), // Define your gradient colors
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14.0), // Adjust radius for rounded corners
                    ),
                    child: ElevatedButton(
                      onPressed: _isButtonDisabled ? null : _handleButtonClick,

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // Make the button background transparent
                        shadowColor: Colors.transparent, // Remove the button's shadow
                      ),
                      child: Text('Book now', style: TextStyle(color: Colors.white)),
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
}

String truncateText(String text, int maxLength) {
  return (text.length > maxLength) ? '${text.substring(0, maxLength)}...' : text;
}