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
      backgroundColor: Colors.white,
      body: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              child: Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/page1.jpeg',)),
            ),
            const Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Expanded(
                flex: 1,
                child: Text(
                  'You can choose the place you want to travel to, and we will find the one that suits you.',
                  style: TextStyle(
                    fontSize: 20, color: Colors.black
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}