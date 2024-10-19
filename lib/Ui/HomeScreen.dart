import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tripfinder_app/CustomWidgets/flightticket_list.dart';
import 'package:tripfinder_app/Ui/Booking.dart';
import 'package:tripfinder_app/Ui/Hotels.dart';
import 'package:tripfinder_app/services/Flight.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = "home";

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  String userName = '';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      print('User ID: ${user!.uid}');
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (userDoc.exists) {
        print('User Document: ${userDoc.data()}');
        setState(() {
          userName = userDoc.data()?['username'] ?? 'User';
          print('User Name: $userName');
        });
      } else {
        print('Document does not exist');
      }
    } else {
      print('No user logged in');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:SingleChildScrollView(
          scrollDirection:Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Welcome, $userName',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
        ),        actions: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, Booking.routName);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Booking()),
                );
              },
              icon: Image.asset("assets/images/book_icon.jpeg"),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Padding(
            padding: const EdgeInsets.only(left: 9.0),
            child: Container(),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: 1000,
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
