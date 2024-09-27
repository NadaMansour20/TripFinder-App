
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tripfinder_app/Api/HotelDescription.dart';


class ApiManager{

  static const String BaseURL='serpapi.com';


  static Future<HotelDescription>getAllHotels() async {
    var uri=Uri.https(BaseURL,'search.json',{
      'api_key':"4d3d903799a4c366e7e2135242ea69dab8c4cec1112efdd0c5c7facbb288d58f",
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
      'api_key':"4d3d903799a4c366e7e2135242ea69dab8c4cec1112efdd0c5c7facbb288d58f",
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
