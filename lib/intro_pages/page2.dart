import 'package:flutter/material.dart';

class page2 extends StatefulWidget {
  const page2({super.key});

  @override
  State<page2> createState() => _page2State();
}

class _page2State extends State<page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Changed to center the content vertically
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0), // Add some vertical padding for spacing
            child: Image.asset('assets/images/ready1.png'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Adjusted horizontal padding
            child: Text(
              'After choosing the place and time , you will be shown the appropiate place , let enjoy',
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
