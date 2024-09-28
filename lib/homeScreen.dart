import 'package:flutter/material.dart';
class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Padding(
          padding: const EdgeInsets.only(left: 9.0),
          child: Icon( Icons.account_circle_outlined,size: 45,color: Colors.deepPurple[800], ),
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
                  Text('Explore the ',
                  style:TextStyle(
                    fontSize: 50,
                    fontWeight:FontWeight.w200,
                  ),
                  ),
                  Row(
                    children: [
                  Text('Beautiful',
                    style:TextStyle(
                      fontSize: 50,
                    ),

                  ),
                      Text('  World',
                          style:TextStyle(
                            fontSize: 50,
                            color:  Colors.deepPurple,
                          ),
                      )
                          ]
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Stack(
              alignment: Alignment.center,
              children: [

                Container(

                  decoration: BoxDecoration(
                  image: DecorationImage(image:AssetImage('assets/images/hotels.avif'),
                    fit: BoxFit.cover,
                  ),
                    borderRadius: BorderRadius.circular(30),
                  ),              height: 200,
                  width: 200,
                ),
                TextButton(onPressed: (){}, child: Text('  Hotels',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child:  Stack(
              alignment: Alignment.center,
              children: [

                Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(image:AssetImage('assets/images/flight.avif'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),              height: 200,
                  width: 200,
                ),
                TextButton(onPressed: (){}, child: Text('Flights',
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
