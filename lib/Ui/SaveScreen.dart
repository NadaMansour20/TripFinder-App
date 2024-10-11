import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/ApiManager.dart';
import 'package:tripfinder_app/Api/HotelDescription.dart';
import 'package:intl/intl.dart';
import 'package:tripfinder_app/Ui/HotelCard.dart';

class SaveScreen extends StatefulWidget {
  static const String routName="saveScreen";

  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  TextEditingController searchController = TextEditingController();
  DateTime? checkInDate;
  DateTime? checkOutDate;
  Future<HotelDescription>? futureHotels;

  String selectedCategory = 'Hotels'; // default category is 'Hotels'

  @override
  void initState() {
    super.initState();
    futureHotels = ApiManager.getAllHotels(); // default hotels on load
  }

  void searchHotels() {
    String? searchQuery = searchController.text.trim();
    String? checkIn = checkInDate != null ? DateFormat('yyyy-MM-dd').format(checkInDate!) : null;
    String? checkOut = checkOutDate != null ? DateFormat('yyyy-MM-dd').format(checkOutDate!) : null;

    if (searchQuery.isNotEmpty || checkIn != null || checkOut != null) {
      setState(() {
        futureHotels = ApiManager.SearchHotels(
          checkIn ?? '2024-12-26',
          checkOut ?? '2024-12-30',
          searchQuery.isNotEmpty ? searchQuery : 'allhotels',
        );
      });
    } else {
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
            "Explore your Trip",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        leading: Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          // Category selection row
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Hotels';
                      futureHotels = ApiManager.getAllHotels(); // Load hotels when selected
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCategory == 'Hotels' ? Colors.purple[200] : Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    'Hotels',
                    style: TextStyle(
                      color: selectedCategory == 'Hotels' ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategory = 'Flights';
                      // You can modify this to load flights from the relevant API when selected
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedCategory == 'Flights' ? Colors.purple[200] : Colors.grey[300],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    'Flights',
                    style: TextStyle(
                      color: selectedCategory == 'Flights' ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Bar & Date Picker
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

          // Date selection for Hotels
          if (selectedCategory == 'Hotels')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: GestureDetector(
                    onTap: () async {
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
          // Hotel content or Flight content
          Expanded(
            child: selectedCategory == 'Hotels'
                ? FutureBuilder<HotelDescription>(
              future: futureHotels,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
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
                      return HotelCard(hotel);
                    },
                  );
                } else {
                  return Center(child: Text('No hotels found.'));
                }
              },
            )
                : Center(child: Text('Flight category selected!')), // Add your flight UI here
          ),
        ],
      ),
    );
  }
}
