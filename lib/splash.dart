import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:triv_intro/onBoarding.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash>
with SingleTickerProviderStateMixin
{
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 4),()
    {
      Navigator.of((context))
          .pushReplacement(MaterialPageRoute(builder: (_)=> const onBoarding(),));
    }
    );

  }

  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/Splash.png', // Your image file
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover, // Ensures the image covers the whole screen
        ),
      ),
    );
  }
}
