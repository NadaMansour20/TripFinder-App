import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/flight_ticket.dart';
import 'CustomButton.dart';

class FlightTicket extends StatelessWidget {
  FlightTicket({super.key, required this.fligthTicketModel});

  final FligthTicketModel fligthTicketModel;
  CollectionReference flights =
      FirebaseFirestore.instance.collection('flights');

  Future<void> addFlight() {
    // Call the user's CollectionReference to add a new user
    return flights
        .add({
          "imageCountrydeparture":
              fligthTicketModel.airportModel!.imageCountrydeparture!,
          "nameCountrydeparture":
              fligthTicketModel.airportModel!.nameCountrydeparture!,
          "namecitydeparture":
              fligthTicketModel.airportModel!.namecitydeparture,
          "imageCountryarrive":
              fligthTicketModel.airportModel!.imageCountryarrive!,
          "nameCountryarrive":
              fligthTicketModel.airportModel!.nameCountryarrive!,
          "namecityarrive": fligthTicketModel.airportModel!.namecityarrive,
          "namedeparture": fligthTicketModel.namedeparture!,
          "namedeparturelong": fligthTicketModel.namedeparturelong!,
          "timedeparture": fligthTicketModel.timedeparture!,
          "timearrive": fligthTicketModel.timearrive!,
          "price": fligthTicketModel.price

          // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  bool _isButtonEnabled = true;

  void _onButtonPressed() {
    if (_isButtonEnabled) {
      _isButtonEnabled = false; // Disable the button
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // Align the cards with space in between
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
                          fligthTicketModel
                              .airportModel!.imageCountrydeparture!,
                          // Replace with your asset image path
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
                              fligthTicketModel
                                  .airportModel!.nameCountrydeparture!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City name= ${fligthTicketModel.airportModel!.namecitydeparture}.\nduration= ${(fligthTicketModel.duration).toString()} minutes.',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
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
                          fligthTicketModel.airportModel!.imageCountryarrive!,
                          // Replace with your asset image path
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
                              fligthTicketModel
                                  .airportModel!.nameCountryarrive!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City name= ${fligthTicketModel.airportModel!.namecityarrive!}.\nduration= ${(fligthTicketModel.duration).toString()} minutes.',
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
        Container(
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
                        truncateText(fligthTicketModel.namedeparturelong!, 10),
                        //fligthTicketModel.namedeparturelong!,//New York
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  Icon(Icons.flight_takeoff, color: Colors.blue),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //
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
                        truncateText(fligthTicketModel.namearrivelong!, 10),
                        // fligthTicketModel.namearrivelong!, //San Francisco
                        style: TextStyle(color: Colors.grey, fontSize: 14),
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
                        truncateText(fligthTicketModel.timedeparture!, 10),
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
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end, //end
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        truncateText(fligthTicketModel.timearrive!, 10),
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
                    "\$${fligthTicketModel.price.toString()}", //\$260
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFFC1E3), // لون وردي فاتح
                      Color(0xFFBA68C8),
                    ], // Define your gradient colors
                  ),
                  borderRadius: BorderRadius.circular(
                      30.0), // Adjust radius for rounded corners
                ),
                child: ElevatedButton(
                  // Remove the button's shadow

                  onPressed: _isButtonEnabled
                      ? () {
                          _onButtonPressed();
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            // Make the button background transparent
                            shadowColor: Colors.transparent,
                          );
                          addFlight();
                          print("done");
                        }
                      : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    // Make the button background transparent
                    shadowColor:
                        Colors.transparent, // Remove the button's shadow
                  ),
                  child: Text('Book now'),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

String truncateText(String text, int maxLength) {
  return (text.length > maxLength)
      ? '${text.substring(0, maxLength)}...'
      : text;
}
