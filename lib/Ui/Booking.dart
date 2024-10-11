import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // استيراد مكتبة Firestore
import 'package:firebase_auth/firebase_auth.dart'; // استيراد مكتبة Firebase Authentication
import 'package:tripfinder_app/payment/PayMentMethod.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // استيراد مكتبة RatingBar

class Booking extends StatefulWidget {
  static const String routName = "book";

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  // قائمة لتخزين بيانات الرحلات والفنادق
  List<Map<String, dynamic>> flightData = [];
  List<Map<String, dynamic>> hotelData = [];
  User? currentUser; // متغير لتخزين معلومات المستخدم الحالي

  @override
  void initState() {
    super.initState();
    fetchFlightData(); // تحميل بيانات الرحلات عند بدء التطبيق
    fetchHotelData(); // تحميل بيانات الفنادق عند بدء التطبيق
    fetchCurrentUser(); // تحميل بيانات المستخدم الحالي
  }

  // دالة لتحميل بيانات المستخدم الحالي
  Future<void> fetchCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser; // الحصول على المستخدم الحالي
      if (user != null) {
        // إذا كان المستخدم موجودًا، احصل على بياناته من Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        setState(() {
          currentUser = user; // تخزين معلومات المستخدم
        });
        // يمكنك استخدام بيانات المستخدم (مثل userDoc.data()) حسب الحاجة
        print('User data: ${userDoc.data()}');
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // دالة لتحميل بيانات الرحلات من Firestore
  Future<void> fetchFlightData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('flights').get();
      setState(() {
        flightData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error fetching flight data: $e");
    }
  }

  // دالة لتحميل بيانات الفنادق من Firestore
  Future<void> fetchHotelData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('hotels').get();
      setState(() {
        hotelData = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error fetching hotel data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Booking'))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // عرض معلومات المستخدم
            if (currentUser != null) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Welcome, ${currentUser!.email}', // عرض البريد الإلكتروني للمستخدم
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
            // عرض بيانات الرحلات
            Column(
              children: flightData.map((flight) {
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(15.0),
                        ),
                        child: Image.network(
                          flight['imageCountryDeparture'],
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              flight['nameCountryDeparture'],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'City: ${flight['nameCityDeparture']}. Duration: ${flight['duration']} minutes.',
                              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),

            // عرض بيانات الفنادق
            Column(
              children: hotelData.map((hotel) {
                return Card(
                  margin: EdgeInsets.all(15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          hotel['imageUrl'],
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                hotel['name'],
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          "${hotel['overallRating'] ?? 0.0}",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        RatingBarIndicator(
                          rating: (hotel['overallRating'] ?? 0.0).toDouble(),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 30.0,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(height: 3),
                        Text(
                          "\$${hotel['ratePerNight']['lowest'].toString()}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
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
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: ()=>PaymentManager.makePayment(40, "EGP"),
              child: Text("Payment"),
            )

          ],
        ),
      ),
    );
  }
}
