import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for logout


import '../Login.dart'; // Import the login screen

class LogoutScreen extends StatelessWidget {
  static const String routName = "logoutScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Sign out the user from Firebase
            await FirebaseAuth.instance.signOut();

            // Navigate to the login screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple, // Purple button
            foregroundColor: Colors.white, // White text
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text('Logout and Return to Login'),
        ),
      ),
    );
  }
}
