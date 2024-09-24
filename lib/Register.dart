import 'package:flutter/material.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/CustomWidgets/CustomTextField.dart';
import 'package:tripfinder_app/Login.dart';

class Register extends StatefulWidget {
  static const String routName = "register";

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  bool _isPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // Wrap with SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/register_logo.jpg"),
              const SizedBox(height:25),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      'Sign Up!',
                      style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFBA68C8), // Light purple color
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const CustomTextField(
                hintText: "User Name",
              ),
              const SizedBox(height: 15),
              const CustomTextField(
                hintText: "Email",
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Password",
                isPasswordField: true,
                isObscure: _isPasswordObscure,
                onSuffixIconTap: () {
                  setState(() {
                    _isPasswordObscure = !_isPasswordObscure;
                  });
                },
              ),
              const SizedBox(height: 15),
              CustomTextField(
                hintText: "Confirm Password",
                isPasswordField: true,
                isObscure: _isConfirmPasswordObscure,
                onSuffixIconTap: () {
                  setState(() {
                    _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                  });
                },
              ),
              const SizedBox(height: 15),
              CustomButton(
                onTap: () {
                  Navigator.pushNamed(context,Login.routName);
                },
                buttonText: "Sign UP",
              ),
            ],
          ),
        ),
      ),
    );
  }
}