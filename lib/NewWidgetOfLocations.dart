import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';
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
    // التحقق من وجود الصور قبل محاولة الوصول إليها
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
              // عرض الصورة إذا كانت موجودة
              imageUrl != null
                  ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                height: 150, // يمكنك ضبط الارتفاع حسب الحاجة
                width: double.infinity, // لجعل الصورة تمتد على عرض الشاشة بالكامل
              )
                  : Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300], // لون بديل في حال عدم وجود صورة
                child: Center(child: Text('No Image')),
              ),
              Text(
                widget.hotel.name ?? " ", // عرض اسم الفندق
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3),
              Row(
                children: [
                  // التحقق من وجود التقييم
                  Text(
                    "${widget.hotel.overallRating ?? 0.0}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  RatingBarIndicator(
                    rating: (widget.hotel.overallRating ?? 0.0)
                        .toDouble(), // تمرير التقييم المستلم من API أو 0.0 في حال كان فارغًا
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
              // عرض السعر إذا كان متاحًا
              Text(
                "${widget.hotel.ratePerNight?.lowest?.toString() ?? '0'}",
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
            ],
          ),
        ),
      ),
    );
  }
}
