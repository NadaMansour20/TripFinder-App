import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripfinder_app/Ui/Booking.dart';
import 'package:tripfinder_app/Ui/Hotels.dart';
import 'package:tripfinder_app/services/Flight.dart'; // Import Firebase Auth

class HomeScreen extends StatelessWidget {
  static const String routName = "home";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;
    String welcomeMessage = currentUser != null ? 'Welcome, $currentUser' : 'Welcome';

    return Scaffold(
      appBar: AppBar(
        title: Text(welcomeMessage), // Display the welcome message
        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Make the container circular
            ),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Booking.routName);
              },
              icon: Image.asset("assets/images/book_icon.jpeg"),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Padding(
            padding: const EdgeInsets.only(left: 9.0),
            child: Container(), // You can add an icon here if needed
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Explore the ',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Beautiful',
                        style: TextStyle(
                          fontSize: 35,
                        ),
                      ),
                      Text(
                        '  World',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.purple[300]!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/images/hotel.avif'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    height: 200,
                    width: 200,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Hotels.routName);
                    },
                    child: const Text(
                      '  Hotels',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/images/flight.avif'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  height: 200,
                  width: 200,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Flight.routName);
                  },
                  child: const Text(
                    'Flights',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
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
