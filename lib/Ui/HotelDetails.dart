import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripfinder_app/Api/HotelDescription.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/Ui/GoogleMap.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HotelDetails extends StatefulWidget {
  static const String routName = "hotel_details";

  final Properties hotel;

  HotelDetails(this.hotel);

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> bookHotelToFirestore() async {
    User? user = FirebaseAuth.instance.currentUser;
    String? userId = user?.uid;

    print("User ID: $userId"); // Check if user is authenticated

    if (userId == null) {
      print("User is not logged in.");
      return; // Ensure the user is logged in
    }

    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

// Hotel data to save for booking
    final hotelData = {
      'booked': true,
      'name': widget.hotel.name ?? 'Unknown Hotel',
      'image': widget.hotel.images != null && widget.hotel.images!.isNotEmpty
          ? widget.hotel.images![0].thumbnail
          : 'No Image Available',
      'ratePerNight': widget.hotel.ratePerNight?.lowest.toString() ?? '0',
      'overallRating': widget.hotel.overallRating ?? 0.0,
      'bookingDate': DateTime.now()
          .toIso8601String(), // To track when the hotel was booked
    };

    try {
      print("Attempting to save hotel data: $hotelData");
// Save hotel booking data to the user's booked hotels collection
      await userDoc.collection('hotels_booked').add(hotelData);
      print("Hotel booking data saved successfully.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Hotel booked successfully!")),
      );
    } catch (e) {
      print("Error saving hotel booking data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to book hotel")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String?>? imageUrls =
        widget.hotel.images?.map((image) => image.thumbnail).toList();
    final List<Ratings>? reviews = widget.hotel.ratings;
    List<String?>? amenities = widget.hotel.amenities?.toList();
    List<NearbyPlaces>? nearby_places = widget.hotel.nearbyPlaces?.toList();

    double? latitude = widget.hotel.gpsCoordinates?.latitude?.toDouble();
    double? longitude = widget.hotel.gpsCoordinates?.longitude?.toDouble();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotel.name ?? 'Hotel Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            imageUrls != null && imageUrls.isNotEmpty
                ? Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              imageUrls[index] ?? "",
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                            );
                          },
                        ),
                        Positioned(
                          bottom: 16,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: _pageController,
                              count: imageUrls.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.purple[200]!,
                                dotColor: Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: Text('No images available'),
                  ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${widget.hotel.overallRating ?? ""}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: RatingBarIndicator(
                            rating:
                                widget.hotel.overallRating?.toDouble() ?? 0.0,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 30.0,
                            direction: Axis.horizontal,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(widget.hotel.description ?? " ",
                        style: TextStyle(fontSize: 15)),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.hotel.ratePerNight?.lowest?.toString() ?? '0',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return HotelReviewsDialog(
                                    reviews: reviews ?? []);
                              },
                            );
                          },
                          child: Text(
                            "${widget.hotel.reviews ?? 0} reviews",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "/night",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 3),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "HOUSE AMENITIES",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
// عرض وسائل الراحة مع أيقونات
                    for (int i = 0; i < amenities!.length; i++)
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.purple[200],
                          ),
                          SizedBox(width: 10),
                          Text(amenities[i] ?? " "),
                        ],
                      ),
                    SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text("Nearby Places",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    for (int i = 0; i < nearby_places!.length; i++) ...[
                      SizedBox(height: 10), // Add space between each place
// Display the place name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          nearby_places[i].name ?? " ",
                        ),
                      ),
                    ],
                    SizedBox(height: 15),
                    if (latitude != null && longitude != null)
                      LocationButton(latitude: latitude, longitude: longitude),
                    SizedBox(height: 3),
                    CustomButton(
                      onTap: () {
                        bookHotelToFirestore(); // Call the booking function
                      },
                      buttonText: "Book Now",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelReviewsDialog extends StatelessWidget {
  final List<Ratings> reviews;

  HotelReviewsDialog({required this.reviews});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Reviews"),
      content: Container(
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${reviews[index].stars} Stars"),
              subtitle: Text("Count: ${reviews[index].count}"),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}
