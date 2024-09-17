import 'package:flutter/material.dart';
import 'Login.dart';

class GetStartedClass extends StatelessWidget {

  String welcomeImage = "images/welcometotripfinder.jpg";
  String textWelcome = "Ready to uncover your next adventure?";
  String welcomeDescription =
      "Let TripFinder guide you to unforgettable destinations! ";
  static const String routName = "getStartedClass";

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
            Container(
              margin: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                colors: [
                  Color(0xFFFFC1E3), // وردي فاتح
                  Color(0xFFBA68C8), // بنفسجي فاتح
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // لجعل خلفية الزر شفافة
                    shadowColor: Colors.transparent, // إزالة الظل الافتراضي
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                ),
                  onPressed: () {

                  Navigator.pushNamed(context,Login.routName);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white),
                    )),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
