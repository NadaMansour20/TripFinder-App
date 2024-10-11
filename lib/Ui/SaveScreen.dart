import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedHotelsState createState() => _SavedHotelsState();
}

class _SavedHotelsState extends State<SavedScreen> {
  User? user;
  List<DocumentSnapshot> savedHotels = [];

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    print("Current User ID: ${user?.uid}"); // Debug: Current User ID
    fetchSavedHotels();
  }

  Future<void> fetchSavedHotels() async {
    if (user != null) {
      var userDoc = FirebaseFirestore.instance.collection('users').doc(user!.uid);
      var hotelsSnapshot = await userDoc.collection('hotels_saved').get();
      setState(() {
        savedHotels = hotelsSnapshot.docs;
      });
    }
  }

  Future<void> deleteHotel(String hotelId) async {
    if (user != null) {
      var userDoc = FirebaseFirestore.instance.collection('users').doc(user!.uid);
      await userDoc.collection('hotels_saved').doc(hotelId).delete(); // Delete from Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: savedHotels.isEmpty
          ? Center(child: Text("No Hotels Saved"))
          : ListView.builder(
        itemCount: savedHotels.length,
        itemBuilder: (context, index) {
          var hotelData = savedHotels[index].data() as Map<String, dynamic>;
          var hotelId = savedHotels[index].id; // Get the hotel document ID

          return Dismissible(
            key: Key(hotelId), // Unique key for each hotel
            background: Container(
              color: Colors.red,
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            direction: DismissDirection.endToStart, // Swipe from right to left
            onDismissed: (direction) {
              // Delete the hotel from Firestore and update the UI
              deleteHotel(hotelId).then((_) {
                setState(() {
                  savedHotels.removeAt(index); // Remove from the local list
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Hotel removed')),
                );
              });
            },
            child: Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    hotelData['image'] != null
                        ? Image.network(
                      hotelData['image'],
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
                            hotelData['name'] ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          "${hotelData['overallRating'] ?? 0.0}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        RatingBarIndicator(
                          rating: (hotelData['overallRating'] ?? 0.0).toDouble(),
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
                      "${hotelData['ratePerNight'] ?? '0'}",
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
        },
      ),
    );
  }
}