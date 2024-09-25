import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/Ui/GoogleMap.dart';

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

  @override
  Widget build(BuildContext context) {
    List<String?>? imageUrls = widget.hotel.images?.map((image) => image.thumbnail).toList();
    final List<Ratings>? reviews = widget.hotel.ratings; // قائمة المراجعات
    List<String?>? amenities = widget.hotel.amenities?.toList();

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
                        imageUrls[index]!,
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
                          "${widget.hotel.overallRating}",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: RatingBarIndicator(
                            rating: widget.hotel.overallRating!.toDouble(),
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
                    SizedBox(height: 3),
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
                            // افتح حوار المراجعات
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return HotelReviewsDialog(reviews: reviews ?? []);
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
                          Text(amenities[i]!),
                        ],
                      ),
                    SizedBox(height: 15),

                    ElevatedButton(
                      onPressed: () {
                        GoogleMap.openMap(latitude!, longitude!);
                      },
                      child: Text("GPS"),
                    ),
                    SizedBox(height: 3),
                    CustomButton(
                      onTap: () {
                        // add to cart
                      },
                      buttonText: "addToCart",
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
        width: double.maxFinite, // يجعل الحوار أعرض
        child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(reviews[index].stars.toString() + " Stars"),
              subtitle: Text("Count: ${reviews[index].count}"),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // إغلاق الحوار
          },
          child: Text("Close"),
        ),
      ],
    );
  }
}
