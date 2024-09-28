import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/ApiManager.dart';
import 'package:tripfinder_app/Api/HotelDescription.dart';
import 'package:intl/intl.dart';
import 'package:tripfinder_app/Ui/HotelCard.dart'; // Add this import for date formatting

class Hotels extends StatefulWidget {
  static const String routName="hotel";


  @override
  _HotelsState createState() => _HotelsState();
}

class _HotelsState extends State<Hotels> {
  TextEditingController searchController = TextEditingController();
  DateTime? checkInDate;
  DateTime? checkOutDate;
  Future<HotelDescription>? futureHotels;

  @override
  void initState() {
    super.initState();
    // Load default hotels on screen load
    futureHotels = ApiManager.getAllHotels();
  }

  void searchHotels() {
    String? searchQuery = searchController.text.trim();
    String? checkIn = checkInDate != null ? DateFormat('yyyy-MM-dd').format(checkInDate!) : null;
    String? checkOut = checkOutDate != null ? DateFormat('yyyy-MM-dd').format(checkOutDate!) : null;

    // Call SearchHotels only if there are search parameters
    if (searchQuery.isNotEmpty || checkIn != null || checkOut != null) {
      setState(() {
        futureHotels = ApiManager.SearchHotels(
          checkIn ?? '2024-12-26', // Default check-in date
          checkOut ?? '2024-12-30', // Default check-out date
          searchQuery.isNotEmpty ? searchQuery : 'allhotels', // Default search query
        );
      });
    } else {
      // Call getAllHotels if no search parameters
      setState(() {
        futureHotels = ApiManager.getAllHotels();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "Explore your Hotel",
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
                  child: GestureDetector(
                    onTap: () {
                      searchHotels();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.purple[200]!,
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
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
                      initialDate: checkOutDate ?? checkInDate ?? DateTime.now(),
                      firstDate: checkInDate ?? DateTime.now(),
                      lastDate: DateTime(2101),
                    );

                    if (pickedCheckOutDate != null) {
                      setState(() {
                        checkOutDate = pickedCheckOutDate;
                      });
                    }
                    searchHotels();
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
            ],
          ),
          // Hotel content
          Expanded(
            child: FutureBuilder<HotelDescription>(
              future: futureHotels,
              builder: (context, snapshot) {
                // print("Response: ${snapshot.data?.toJson().toString()}");

                if (snapshot.hasError) {
                  //print("Response: ${snapshot.error.toString()}");
                  return Center(child: Text(snapshot.error.toString()));
                }
                else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                var hotelLocation = snapshot.data;

                if (hotelLocation?.searchMetadata?.status == "Success") {
                  return ListView.builder(
                    itemCount: hotelLocation?.properties?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var hotel = hotelLocation!.properties![index];
                      return HotelCard(hotel);
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
