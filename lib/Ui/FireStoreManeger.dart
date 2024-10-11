/*
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  FirestoreManager(this.userId);

  // Get favorite hotels
  Future<List<String>> getFavoriteHotels() async {
    QuerySnapshot snapshot = await _firestore.collection('users/$userId/hotels')
        .where('category', isEqualTo: 'favorite').get();
    return snapshot.docs.map((doc) => doc['hotelId'] as String).toList();
  }

  // Get booked hotels
  Future<List<String>> getBookedHotels() async {
    QuerySnapshot snapshot = await _firestore.collection('users/$userId/hotels')
        .where('category', isEqualTo: 'booked').get();
    return snapshot.docs.map((doc) => doc['hotelId'] as String).toList();
  }
}
*/
