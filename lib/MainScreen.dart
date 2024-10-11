import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Ui/Booking.dart';
import 'package:tripfinder_app/Ui/HomeScreen.dart';
import 'package:tripfinder_app/Ui/ProfileScreen.dart';
import 'package:tripfinder_app/Ui/SaveScreen.dart';

class MainScreen extends StatefulWidget {
  static const String routName = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Container(

        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFC1E3), // لون وردي فاتح
              Color(0xFFBA68C8), // لون بنفسجي فاتح
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: selectedIndex,
          onTap:(index){
            selectedIndex=index;
            setState(() {

            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home3.jpg")),
              label: "Home",

            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/save.png"),),
              label: "Save",

            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/profile.jpg")),
              label: "Profile",
            ),

          ],

          selectedIconTheme: const IconThemeData(
              color: Colors.white
          ),
          unselectedIconTheme:const IconThemeData(
              color:  Colors.white70),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),
      ),
      body: ListOfTabs[selectedIndex],
    );

  }
  List<Widget> ListOfTabs=[HomeScreen(),SavedScreen(),ProfileScreen()];


}