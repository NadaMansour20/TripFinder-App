import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/ApiManager.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';
import 'package:tripfinder_app/Ui/NewWidgetOfLocations.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  DateTime? checkInDate;
  DateTime? checkOutDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Explore",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Icon(Icons.arrow_back),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search for hotels...",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.grey[200]!,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundColor: Colors.purple[200]!,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Date selection
                Padding(
                  padding: EdgeInsets.all(30),
                  child: GestureDetector(
                    onTap: () async {
                      // Show date picker for check-in date
                      DateTime? pickedCheckInDate = await showDatePicker(
                        context: context,
                        initialDate: checkInDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedCheckInDate != null) {
                        setState(() {
                          checkInDate = pickedCheckInDate;

                        });
                      }

                      // Show date picker for check-out date
                      DateTime? pickedCheckOutDate = await showDatePicker(
                        context: context,
                        initialDate: checkOutDate ?? checkInDate?.add(Duration(days: 1)) ?? DateTime.now(),
                        firstDate: checkInDate ?? DateTime.now(),
                        lastDate: DateTime(2101),
                      );

                      if (pickedCheckOutDate != null) {
                        setState(() {
                          checkOutDate = pickedCheckOutDate;
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Choose date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${checkInDate != null ? DateFormat('dd MMM yyyy').format(checkInDate!) : 'Select Check-in'} - ${checkOutDate != null ? DateFormat('dd MMM yyyy').format(checkOutDate!) : 'Select Check-out'}",
                          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Number of Individuals", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Hotel content
          Expanded(
            child: FutureBuilder<HotelsModel>(
              future: ApiManager.getAllHotels(),
              builder: (context, snapshot) {
                print("Response: ${snapshot.data?.toJson().toString()}");

                if (snapshot.hasError) {
                  print("Response: ${snapshot.error.toString()}");
                  return Center(child: Text(snapshot.error.toString()));
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                var hotelLocation = snapshot.data;

                if (hotelLocation?.searchMetadata?.status == "Success") {
                  return ListView.builder(
                    itemCount: hotelLocation?.properties?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var hotel = hotelLocation!.properties![index];
                      return NewWidgetOfLocations(hotel);
                    },
                  );
                } else {
                  return Center(child: Text('No hotels found.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
