import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   VoidCallback ?onTap;//شيلتfinal
  final String buttonText;

   CustomButton({super.key,  this.onTap, required this.buttonText});//شيلت const
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFC1E3), // لون وردي فاتح
              Color(0xFFBA68C8), // لون بنفسجي فاتح
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}