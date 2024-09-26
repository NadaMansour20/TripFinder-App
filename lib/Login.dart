import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/CustomWidgets/CustomTextField.dart';
import 'package:tripfinder_app/Register.dart';

import 'homaPage.dart';

class Login extends StatefulWidget {
  static const String routName = "login";

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _isPasswordObscure = true;
  String? email; //
  String? pass; //
  GlobalKey<FormState> formkey = GlobalKey();
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
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
                    CustomTextField(//شيلت الconst
                      hintText: "Email",
                      onChanged: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(//شيلت الconst
                      onChanged: (data) {
                        pass = data;
                      },
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
                      onTap: () async {
                        if(formkey.currentState!.validate()){
                          isLoading=true;
                          setState(() {

                          });
                          //بيانات جاية من المستقب
                          try {
                            await userlogin(); //
                            showSnackBar(context, 'Operation Success');
                            Navigator.pushNamed(context, HomePage.routName);
                            // Navigator.pushNamed(context, Register.routName);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'user-not-found') {
                              showSnackBar(context, 'user not found');
                            } else if (ex.code == 'wrong-password') {
                              //email already exists
                              showSnackBar(context, 'wrong-password');
                            }
                          } catch (ex) {
                            showSnackBar(context, 'there was an error');
                          }
                          isLoading=false;
                          setState(() {

                          });
                        }
                        else{}
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
            ),
          )),
    );
  }
  Future<void> userlogin() async {
    UserCredential user = await //
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: pass!); //
  }

  void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }
}
