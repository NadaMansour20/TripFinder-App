import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
class savedFlights extends StatefulWidget {
  const savedFlights({super.key});

  @override
  State<savedFlights> createState() => _savedFlightsState();
}

class _savedFlightsState extends State<savedFlights> {

  List <QueryDocumentSnapshot>data =[];
  getData()async{
    QuerySnapshot querySnapshot =  await FirebaseFirestore.instance.collection("flights").get();
    data.addAll(querySnapshot.docs);
    setState(() {

    });

  }


//for unsave
  deleteData()async{
    var i;
    await FirebaseFirestore.instance.collection("flights").doc(data[i].id).delete();
Navigator.of(context).pushReplacementNamed("savedFlights");

  }







  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
