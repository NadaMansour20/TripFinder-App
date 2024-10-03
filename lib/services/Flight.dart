import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/CustomWidgets/flightticket_list.dart'; // Your actual path

class Flight extends StatefulWidget {
  static const String routName = "Flight";
  const Flight({Key? key}) : super(key: key);

  @override
  _FlightState createState() => _FlightState();
}

class _FlightState extends State<Flight> {
  String selectedFromCityCode = "Select From"; // Selected From city code
  String selectedToCityCode = "Select To"; // Selected To city code

  // City codes and names map
  Map<String, String> cities = {
    "CAI": "Cairo",
    "JFK": "New York",
    "CDG": "Paris",
    "LHR": "London",
    "NRT": "Tokyo",
    "DXB": "Dubai",
  };

  // Method to open city selection dialog
  Future<void> _selectCity(BuildContext context, String label) async {
    String? selectedCityCode = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select $label City'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: cities.length,
              itemBuilder: (BuildContext context, int index) {
                String cityCode = cities.keys.elementAt(index);
                String cityName = cities[cityCode]!;
                return ListTile(
                  title: Text("$cityName ($cityCode)"), // Show city name and code
                  onTap: () {
                    Navigator.pop(context, cityCode); // Return the city code (key)
                  },
                );
              },
            ),
          ),
        );
      },
    );

    if (selectedCityCode != null) {
      setState(() {
        if (label == "From") {
          selectedFromCityCode = selectedCityCode; // Update selected From city code
        } else {
          selectedToCityCode = selectedCityCode; // Update selected To city code
        }
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
            "Book your Tickets",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _selectCity(context, "From"), // Select From city
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    selectedFromCityCode == "Select From" ? selectedFromCityCode : "${cities[selectedFromCityCode]} ($selectedFromCityCode)", // Display selected From city
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _selectCity(context, "To"), // Select To city
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    selectedToCityCode == "Select To" ? selectedToCityCode : "${cities[selectedToCityCode]} ($selectedToCityCode)", // Display selected To city
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              if (selectedFromCityCode != "Select From" && selectedToCityCode != "Select To") {
                // Trigger flight search when both cities are selected
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlightTicketList(
                      departureCityCode: selectedFromCityCode, // Pass From city code
                      arrivalCityCode: selectedToCityCode,    // Pass To city code
                    ),
                  ),
                );
              } else {
                // Show error if cities are not selected
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Please select both From and To cities."),
                ));
              }
            },
            child: Text("Search Flights"),
          ),
        ],
      ),
    );
  }
}