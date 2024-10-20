import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../stripe_payment/payment_manager.dart';

class Booking extends StatefulWidget {
  @override
  BookingState createState() => BookingState();
}

class BookingState extends State<Booking> {
  User? user = FirebaseAuth.instance.currentUser;
  List<DocumentSnapshot> savedHotels = [];
  List<DocumentSnapshot> savedFlights = [];

  @override
  void initState() {
    super.initState();
    loadSavedHotels();
    loadSavedFlights();
  }

  Future<List<DocumentSnapshot>> fetchSavedHotels() async {
    List<DocumentSnapshot> savedHotels = [];

    if (user != null) {
      try {
        var userDoc = FirebaseFirestore.instance.collection('users').doc(user!.uid);
        var hotelsSnapshot = await userDoc.collection('hotels_booked').get();
        savedHotels = hotelsSnapshot.docs;
        print("Fetched saved hotels: ${savedHotels.length}");
      } catch (error) {
        print("Error fetching saved hotels: $error");
      }
    } else {
      print("User is not logged in.");
    }

    return savedHotels;
  }

  Future<List<DocumentSnapshot>> fetchSavedFlights() async {
    List<DocumentSnapshot> savedFlights = [];

    if (user != null) {
      try {
        var userDoc = FirebaseFirestore.instance.collection('users').doc(user!.uid);
        var flightsSnapshot = await userDoc.collection('flights').get();
        savedFlights = flightsSnapshot.docs;
        print("Fetched saved flights: ${savedFlights.length}");
      } catch (error) {
        print("Error fetching saved flights: $error");
      }
    } else {
      print("User is not logged in.");
    }

    return savedFlights;
  }

  void loadSavedHotels() async {
    List<DocumentSnapshot> hotels = await fetchSavedHotels();
    setState(() {
      savedHotels = hotels;
    });
  }

  void loadSavedFlights() async {
    List<DocumentSnapshot> flights = await fetchSavedFlights();
    setState(() {
      savedFlights = flights;
    });
  }

  void onButtonPressed() {
   PaymentManager.makePayment(40000, "EGP");

  }

  Future<void> deleteHotel(String hotelId) async {
    if (user != null) {
      try {
        var userDoc = FirebaseFirestore.instance.collection('users').doc(user!.uid);
        await userDoc.collection('hotels_booked').doc(hotelId).delete();
      } catch (error) {
        print("Error deleting hotel: $error");
      }
    }
  }

  Future<void> deleteFlight(String flightId) async {
    if (user != null) {
      try {
        var userDoc = FirebaseFirestore.instance.collection('users').doc(user!.uid);
        await userDoc.collection('flights').doc(flightId).delete();
      } catch (error) {
        print("Error deleting flight: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Booking')),
      ),
      body: Column(
        children: [
          // Title for Hotels List
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hotels',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: savedHotels.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: savedHotels.length,
              itemBuilder: (context, index) {
                var hotelData = savedHotels[index].data() as Map<String, dynamic>;
                var hotelId = savedHotels[index].id; // Get hotel document ID

                return Dismissible(
                  key: Key(hotelId), // Unique key for each hotel
                  background: Container(
                    color: Colors.red,
                    alignment: AlignmentDirectional.centerEnd,
                    child: const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  direction: DismissDirection.endToStart, // Swipe from right to left
                  onDismissed: (direction) {
                    deleteHotel(hotelId).then((_) {
                      setState(() {
                        savedHotels.removeAt(index); // Remove from the local list
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Hotel removed')),
                      );
                    });
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            hotelData['image'] ?? 'https://via.placeholder.com/150',
                            fit: BoxFit.cover,
                            height: 150,
                            width: double.infinity,
                          ),
                          SizedBox(height: 8),
                          Text(hotelData['name'] ?? 'Unnamed Hotel',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text("Price per Night: ${hotelData['ratePerNight'] ?? 'Unknown Price'}"),
                          Text("Overall Rating:"),
                          RatingBarIndicator(
                            rating: (hotelData['overallRating'] ?? 0.0).toDouble(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount:savedHotels.length,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Title for Flights List
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Flights',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: savedFlights.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: savedFlights.length,
              itemBuilder: (context, index) {
                var flightData = savedFlights[index].data() as Map<String, dynamic>;
                var flightId = savedFlights[index].id; // Get flight document ID

                return Dismissible(
                  key: Key(flightId), // Unique key for each flight
                  background: Container(
                    color: Colors.red,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  direction: DismissDirection.endToStart, // Swipe from right to left
                  onDismissed: (direction) {
                    deleteFlight(flightId).then((_) {
                      setState(() {
                        savedFlights.removeAt(index); // Remove from the local list
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Flight removed')),
                      );
                    });
                  },
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Padding(
                      padding: const EdgeInsets.all(10), // تعديل padding مثل بطاقة الفندق
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("DepartureCity: ${flightData['departureCity'] ?? 'Unknown Departure'}"),
                          Text("ArrivalCity: ${flightData['arrivalCity'] ?? 'Unknown Arrival'}"),
                          Text("Departure Time: ${flightData['departureTime'] ?? 'Unknown Time'}"),
                          Text("Arrival Time: ${flightData['arrivalTime'] ?? 'Unknown Time'}"),
                          Text("Duration: ${flightData['duration'] ?? 'Unknown Duration'} minutes"),
                          Text("Price: \$${flightData['price'] ?? 'Unknown Price'}"),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: onButtonPressed,
              child: Text(
                'Payment',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple[300],
                minimumSize: Size(double.infinity, 50),
              ).copyWith(
                elevation: MaterialStateProperty.all(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}