import 'package:flutter/material.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/CustomWidgets/CustomTextField.dart';
import 'package:tripfinder_app/Register.dart';

class Login extends StatefulWidget {
  static const String routName = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Column(
              children: [
                Container(
                  margin:const EdgeInsets.symmetric(vertical: 70),
                  child: const Row(
                    children: [
                      Text("Welcome Back",style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color:Color(0xFFBA68C8), // لون بنفسجي فاتح
                      )),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Text(
                        'Sign In!',
                        style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color:Color(0xFFBA68C8), // لون بنفسجي فاتح
                        ),
                      ),
                    ],
                  ),
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
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, Login.routName);
                  },
                  buttonText: "Sign In",
                ),
                Row(
                  children: [
                    const Text(
                      'don\'t have an account ?',
                      style: TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  TextButton(onPressed: (){
                    Navigator.pushNamed(context, Register.routName);

                  },
                    child: const Text(" REGISTER",style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:Color(0xFFBA68C8))),
                  ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
