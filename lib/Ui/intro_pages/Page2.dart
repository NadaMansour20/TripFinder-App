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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Image.asset('assets/images/page2.jpeg'),
          ),
          const Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
            child: Text(
              'After choosing the place and time , you will be shown the appropriate place , let enjoy',
              style: TextStyle(
                fontSize: 20, color: Colors.black
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}