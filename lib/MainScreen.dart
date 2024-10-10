import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth for logout
import 'package:tripfinder_app/Ui/HomeScreen.dart';
import 'package:tripfinder_app/Ui/ProfileScreen.dart';
import 'package:tripfinder_app/Ui/SaveScreen.dart';
import 'package:tripfinder_app/Ui/LogoutScreen.dart'; // Import the Logout Screen

import '../Login.dart';
class MainScreen extends StatefulWidget {
  static const String routName = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFC1E3), // Pink gradient
              Color(0xFFBA68C8), // Purple gradient
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: selectedIndex,
          onTap: (index) {
            if (index == 3) { // Index for the Logout button
              // Navigate to the Logout screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LogoutScreen()),
              );
            } else {
              setState(() {
                selectedIndex = index;
              });
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home3.jpg")),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/save.png")),
              label: "Save",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/profile.jpg")),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: "Logout",
            ),
          ],
          selectedIconTheme: const IconThemeData(color: Colors.purple), // Purple icons
          unselectedIconTheme: const IconThemeData(color: Colors.white), // White icons
          selectedItemColor: Colors.white, // White labels when selected
          unselectedItemColor: Colors.white70, // Slightly faded white when unselected
        ),
      ),
      body: ListOfTabs[selectedIndex],
    );
  }

  List<Widget> ListOfTabs = [HomeScreen(), SaveScreen(), ProfileScreen()];
}
