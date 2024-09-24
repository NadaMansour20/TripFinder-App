import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';

class HotelDetails extends StatefulWidget {
  static const String routName = "hotel_details";

  final Properties hotel;

  HotelDetails(this.hotel);

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {
    // استخراج عناوين URL للصور
    List<String?>? imageUrls = widget.hotel.images?.map((image) => image.thumbnail).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hotel.name ?? 'Hotel Details'),
      ),
      body: Column(
        children: [
          imageUrls != null && imageUrls.isNotEmpty
              ? Container(
            height: MediaQuery.of(context).size.height / 4, // تحديد ارتفاع الربع
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // جعل القائمة أفقية
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(0), // يمكنك ضبط الهوامش حسب الحاجة
                  child: Image.network(
                    imageUrls[index]!,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width, // عرض الصورة بالكامل
                  ),
                );
              },
            ),
          )
              : Center(
            child: Text('No images available'),
          ),
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

        ],
      ),
    );
  }
}
