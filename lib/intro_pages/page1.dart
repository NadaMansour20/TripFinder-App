import 'package:flutter/material.dart';

class page1 extends StatefulWidget {
  const page1({super.key});

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Changed to center the content vertically
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0), // Add some vertical padding for spacing
            child: Image.asset('assets/images/search1.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted horizontal padding
            child: Text(
              'You can choose the place you want to travel to, and we will find the one that suits you.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF3A074A),
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
