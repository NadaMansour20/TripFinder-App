import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart' ;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tripfinder_app/CustomWidgets/HotelDetails.dart';



class NewWidgetOfLocations extends StatefulWidget {

  final Properties hotel;

  NewWidgetOfLocations(this.hotel);

  @override
  State<NewWidgetOfLocations> createState() => _NewWidgetOfLocationsState();

}

class _NewWidgetOfLocationsState extends State<NewWidgetOfLocations> {
  @override
  Widget build(BuildContext context) {



    return  GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HotelDetails(widget.hotel),
            ),
          );

        },
      child: Card(
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.hotel.images![1].thumbnail
                    .toString(), // Replace 'url' with the actual property name that holds the image URL
                fit: BoxFit.cover,
                height:
                150, // You can adjust the height as needed
                width: double
                    .infinity, // Makes the image stretch across the width
              ),
              Text(
                widget.hotel.name ?? " ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    "${widget.hotel.overallRating}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  RatingBarIndicator(
                    rating: widget.hotel.overallRating!
                        .toDouble(), // هنا يتم تمرير التقييم المستلم من API
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5, // عدد النجوم الإجمالي
                    itemSize: 30.0, // حجم النجوم
                    direction: Axis.horizontal, // اتجاه النجوم
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                "${widget.hotel.ratePerNight?.lowest.toString() ?? '0'}",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 3),
              Text(
                "/night",
                style: TextStyle(color: Colors.grey),
              ),

              SizedBox(height: 3),
              // Add more hotel details as needed
            ],
          ),
        ),
      ),
    );
  }
}

