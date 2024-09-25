import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tripfinder_app/Api/ApiManager.dart';
import 'package:tripfinder_app/Api/HotelsModel.dart';
import 'package:tripfinder_app/NewWidgetOfLocations.dart';

class HomeScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();


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
          // شريط البحث البيضاوي
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
                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal:20),
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
                SizedBox(width: 30,),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: CircleAvatar(
                    backgroundColor: Colors.purple[200]!, // لون الخلفية للأيقونة الدائرية
                    child: const Icon(
                      Icons.search, // هنا الأيقونة التي تريد استخدامها
                      color: Colors.white, // لون الأيقونة
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // اختيار التواريخ
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Text("Choose date", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("12 Dec- 20 Dec", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Number of Rooms", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("1 Room - 2 Adults", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),

          // محتوى الفنادق
          Expanded(
            child: FutureBuilder<HotelsModel>(
              future: ApiManager.getAllHotels(),
              builder: (context, snapshot) {
                print("Response${snapshot.data?.toJson().toString()}");

                if (snapshot.hasError) {
                  print("Response${snapshot.error.toString()}");
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
