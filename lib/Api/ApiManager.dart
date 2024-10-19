import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tripfinder_app/Api/HotelDescription.dart';

class ApiManager {
  static const String BaseURL = 'serpapi.com';

  static String getDefaultDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(now);
  }

  static String getDatePlusDays(int days) {
    var futureDate = DateTime.now().add(Duration(days: days));
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(futureDate);
  }

  static Future<HotelDescription> getAllHotels() async {
    String today = getDefaultDate();
    String futureDate = getDatePlusDays(10);

    var uri = Uri.https(BaseURL, 'search.json', {
      'api_key':
      "f8deb06e89f6b626f7e49e800ae2f173a11e6a1f2d8b6f7bbff7cc143f430711",
      'q': 'allhotels', // all hotels
      'engine': 'google_hotels',
      'check_in_date': today,
      'check_out_date': futureDate // الخروج بعد 10 أيام
    });
    var response = await http.get(uri);
    var json = jsonDecode(response.body);
    HotelDescription model = HotelDescription.fromJson(json);
    return model;
  }

  static Future<HotelDescription> SearchHotels(
      String checkIn, String checkOut, String Country) async {
    var uri = Uri.https(BaseURL, 'search.json', {
      'api_key':
      "f8deb06e89f6b626f7e49e800ae2f173a11e6a1f2d8b6f7bbff7cc143f430711",
      'q': Country,
      'engine': 'google_hotels',
      'check_in_date': checkIn,
      'check_out_date': checkOut,
    });

    var response = await http.get(uri);

    var json = jsonDecode(response.body);
    HotelDescription model = HotelDescription.fromJson(json);
    return model;
  }
}