import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tripfinder_app/Api/HotelDescription.dart';
import 'package:tripfinder_app/Ui/HotelDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HotelCard extends StatefulWidget {
  final Properties hotel;

  HotelCard(this.hotel); // Constructor to receive hotel properties

  @override
  State<HotelCard> createState() => _HotelCardState();
}

class _HotelCardState extends State<HotelCard> {
  bool isSaved = false; // Track if the hotel is saved

  Future<void> saveHotelToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;

    if (userId == null) return; // Ensure the user is logged in

    DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    // Hotel data to save
    final hotelData = {
      'saved': true,
      'name': widget.hotel.name ?? 'Unknown Hotel',
      'image': widget.hotel.images != null && widget.hotel.images!.isNotEmpty
          ? widget.hotel.images![0].thumbnail
          : 'No Image Available',
      'ratePerNight': widget.hotel.ratePerNight?.lowest.toString() ?? '0',
      'overallRating': widget.hotel.overallRating ?? 0.0,
    };

    try {
      // Save hotel data to the user's saved hotels collection
      await userDoc.collection('hotels_saved').add(hotelData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hotel saved successfully!")),
      );
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to book hotel")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String? imageUrl = (widget.hotel.images != null && widget.hotel.images!.isNotEmpty)
        ? widget.hotel.images![0].thumbnail
        : null;

    return GestureDetector(
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
              imageUrl != null
                  ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 150,
                width: double.infinity,
              )
                  : Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
                child: Center(child: Text('No Image')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      widget.hotel.name ?? "",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: ImageIcon(
                      AssetImage(isSaved ? "assets/images/saved.png" : "assets/images/save.png"),
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        isSaved = !isSaved; // Toggle save state
                      });

                      // Call the method to save hotel data to Firestore
                      saveHotelToFirestore();
                    },
                  ),
                ],
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  Text(
                    "${widget.hotel.overallRating ?? 0.0}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  RatingBarIndicator(
                    rating: (widget.hotel.overallRating ?? 0.0).toDouble(),
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 30.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              SizedBox(height: 3),
              Text(
                "${widget.hotel.ratePerNight?.lowest.toString() ?? '0'}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 3),
              const Text(
                "/night",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}