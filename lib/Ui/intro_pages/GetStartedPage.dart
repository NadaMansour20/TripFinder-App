import 'package:flutter/material.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/Login.dart';

class GetStartedPage extends StatefulWidget {

  static const String routName = "getStartedClass";

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  String welcomeImage = "assets/images/welcometotripfinder.jpg";

  String textWelcome = "Ready to uncover your next adventure?";

  String welcomeDescription = "Let TripFinder guide you to unforgettable destinations! ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Image.asset(welcomeImage),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Text(textWelcome,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 23)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
              child: Text(
                welcomeDescription,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            CustomButton(
              onTap: () {
                Navigator.pushNamed(context, Login.routName);
              },
              buttonText: "Get Started",
            ),
          ],
        ),
      ),
    );
  }
}
