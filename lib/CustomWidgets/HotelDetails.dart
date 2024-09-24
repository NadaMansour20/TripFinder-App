import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';
import 'package:tripfinder_app/CustomWidgets/CustomButton.dart';
import 'package:tripfinder_app/GoogleMap.dart';

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
    _pageController.dispose(); // تأكد من التخلص من PageController عند الانتهاء
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // جمع الصور من بيانات الفندق
    List<String?>? imageUrls =
    widget.hotel.images?.map((image) => image.thumbnail).toList();

    // جمع وسائل الراحة من بيانات الفندق
    List<String?>? amenities = widget.hotel.amenities?.toList();

    double? latitude=widget.hotel.gpsCoordinates?.latitude?.toDouble();
    double? longitude=widget.hotel.gpsCoordinates?.longitude?.toDouble();



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
              height: MediaQuery.of(context).size.height / 3, // تحديد ارتفاع الربع
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _pageController, // ربط PageController بـ PageView
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Image.network(
                        imageUrls[index]!,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width, // عرض الصورة بالكامل
                      );
                    },
                  ),
                  // إضافة النقاط أعلى الصورة باستخدام Positioned
                  Positioned(
                    bottom: 16, // تحديد موقع النقاط على الصورة (16 من الأسفل)
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController, // ربط PageController بالمؤشر
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
                            itemBuilder: (context, index) => Icon(
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

                    Text(
                      "${widget.hotel.ratePerNight?.lowest?.toString() ?? '0'}",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                    Text(
                      "/night",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "HOUSE AMENITIES",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // عرض وسائل الراحة مع أيقونات
                    for (int i = 0; i < amenities!.length; i++)
                      Row(
                        children: [
                          // إضافة الأيقونة بناءً على نوع وسيلة الراحة
                          Icon(
                                Icons.check,
                            color: Colors.purple[200],
                          ),
                          SizedBox(width: 10),
                          Text(amenities[i]!),
                        ],
                      ),
                    SizedBox(height: 15,),
                    ElevatedButton(onPressed:() {
                      GoogleMap.openMap(latitude!, longitude!);
                    }
                    , child:Text("GPS") ),
                    SizedBox(height: 3),
                    CustomButton(onTap:(){

                      //add to cart
                    }, buttonText:"addToCart"
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
