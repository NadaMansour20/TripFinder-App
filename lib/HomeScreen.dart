import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/ApiManager.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';
import 'package:tripfinder_app/NewWidgetOfLocations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder<HotelsModel>(
            future: ApiManager.getAllHotels(),
            builder: (context, snapshot) {
              print("Response${snapshot.data?.toJson().toString()}");

              if (snapshot.hasError) {
                print("Response${snapshot.error.toString()}");
                return Center(child: Text(snapshot.error.toString()));
              }
              // Load API
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              var hotelLocation = snapshot.data;

              // تحقق مما إذا كانت البيانات ناجحة
              if (hotelLocation?.searchMetadata?.status == "Success") {
                return Expanded(
                  child: ListView.builder(
                    itemCount: hotelLocation?.properties?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var hotel = hotelLocation!.properties![index];
                      return NewWidgetOfLocations(hotel);


                    },
                  ),
                );
              } else {
                return Center(child: Text('No hotels found.'));
              }
            },
          ),
        ],
      ),
    );
  }
}
