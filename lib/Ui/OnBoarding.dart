import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripfinder_app/Login.dart';
import 'package:tripfinder_app/MainScreen.dart';
import 'package:tripfinder_app/Ui/intro_pages/GetStartedPage.dart';
import 'package:tripfinder_app/Ui/intro_pages/Page1.dart';
import 'package:tripfinder_app/Ui/intro_pages/Page2.dart';

class onBoarding extends StatefulWidget{

  static const String routName="on_barding";

  const onBoarding ({Key? key}) : super(key :key);
  _onBoardingState createState() => _onBoardingState();
}
class _onBoardingState extends State<onBoarding> {
  bool firstOpen = true;
  PageController _cont = PageController();
  _onIntroEnd(context) async {
    Navigator.of(context).
    push(MaterialPageRoute(builder: (context) => MainScreen()));
  }
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!firstOpen) {
        _onIntroEnd(context);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return firstOpen ?
    Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, GetStartedPage.routName);
          },
              child:
              const Text('Skip',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              )
          )
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: _cont, // Attach controller to PageView
            children: [
              page1(),
              page2(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.8),
            child: SmoothPageIndicator(
              controller: _cont, // Attach controller to SmoothPageIndicator
              count: 2, // Number of pages
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.purple[300]!, // Customize as needed
              ),
            ),
          ),
        ],
      ),
    ):
    WillPopScope(
      onWillPop: () async => false,
      child: const Scaffold(
        body: SizedBox.expand(
            child:Image(image: AssetImage('assets/images/ready1.png'))
        ),
      ),
    )
    ;
  }
}