import 'package:flutter/material.dart';
import 'package:tripfinder_app/CustomWidgets/flightticket_list.dart';
import 'package:tripfinder_app/Ui/Hotels.dart';
import 'package:tripfinder_app/services/Flight.dart';



class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Padding(
          padding: const EdgeInsets.only(left: 9.0),
        )),
      ),
      body:
      Column(
        children: [
          Container(
            height: 150,
            width: 1000,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Explore the ',
                    style:TextStyle(
                      fontSize:35,
                      fontWeight:FontWeight.w200,
                    ),
                  ),
                  Row(
                      children: [
                        const Text('Beautiful',
                          style:TextStyle(
                            fontSize:35,
                          ),
                        ),
                        Text('  World',
                          style:TextStyle(
                            fontSize: 35,
                            color:  Colors.purple[300]!,
                          ),
                        )
                      ]
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(image:AssetImage('assets/images/hotel.avif'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),              height: 200,
                    width: 200,
                  ),
                  TextButton(onPressed:(){

                    Navigator.pushNamed(context,Hotels.routName);

                  }, child: const Text('  Hotels',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child:  Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(image:AssetImage('assets/images/flight.avif'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),              height: 200,
                  width: 200,
                ),
                TextButton(onPressed: (){

                  Navigator.pushNamed(context,Flight.routName);
                }, child: const Text('Flights',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),),
              ],
            ),
          )
        ],
      )
      ,
    );
  }
}