import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tripfinder_app/Api/HotelDescription.dart';
import 'package:tripfinder_app/Ui/Booking.dart';
import 'package:tripfinder_app/Ui/HotelDetails.dart';
import 'package:tripfinder_app/Login.dart';
import 'package:tripfinder_app/MainScreen.dart';
import 'package:tripfinder_app/Register.dart';
import 'package:tripfinder_app/Ui/Hotels.dart';
import 'package:tripfinder_app/Ui/OnBoarding.dart';
import 'package:tripfinder_app/Ui/WelcomePage.dart';
import 'package:tripfinder_app/Ui/intro_pages/GetStartedPage.dart';
import 'package:tripfinder_app/firebase_options.dart';
import 'package:tripfinder_app/payment/PayMentKeys.dart';
import 'package:tripfinder_app/services/Flight.dart';


void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey=ApiKeys.publicKey;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: GetStartedClass.routName,
     // initialRoute:Welcomepage.routName,
      home: Welcomepage(),

      routes: {
        GetStartedPage.routName:(BuildContext)=>GetStartedPage(),
        onBoarding.routName:(BuildContext)=>onBoarding(),
        Hotels.routName:(BuildContext)=>Hotels(),
         Login.routName:(BuildContext)=>Login(),
         Register.routName:(BuildContext)=>Register(),
        MainScreen.routName:(BuildContext)=>MainScreen(),
        HotelDetails.routName: (context) => HotelDetails(ModalRoute.of(context)!.settings.arguments as Properties),
        Flight.routName:(BuildContext)=>Flight(),
        Booking.routName:(context)=>Booking()
      },

    );

  }
  
}
