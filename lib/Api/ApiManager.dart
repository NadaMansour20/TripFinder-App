
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tripfinder_app/Api/HotelDescription.dart';


class ApiManager{

  static const String BaseURL='serpapi.com';


  static Future<HotelDescription>getAllHotels() async {
    var uri=Uri.https(BaseURL,'search.json',{
      'api_key':"8583831c20a1efc505c2d99555d5b72ffb1b5ba90f23c147f15eca51a9d64885",
      'q':'allhotels', // all hotels
      'engine':'google_hotels',
      'check_in_date':'2024-12-26',
      'check_out_date':'2024-12-30'
    });
    var response=await http.get(uri);
    var json = jsonDecode(response.body);
    HotelDescription model = HotelDescription.fromJson(json);
    return model;
  }

  static Future<HotelDescription>SearchHotels(String checkIn,String checkOut,String Country) async {

    var uri=Uri.https(BaseURL,'search.json',{
      'api_key':"8583831c20a1efc505c2d99555d5b72ffb1b5ba90f23c147f15eca51a9d64885",
      'q':Country,
      'engine':'google_hotels',
      'check_in_date':checkIn,
      'check_out_date':checkOut,
    });

    var response=await http.get(uri);

    var json = jsonDecode(response.body);
    HotelDescription model = HotelDescription.fromJson(json);
    return model;

  }





}
