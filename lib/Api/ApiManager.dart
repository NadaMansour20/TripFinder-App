import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tripfinder_app/Api/HotelDescription.dart';

class ApiManager {
  static const String BaseURL = 'serpapi.com';

  // دالة للحصول على التاريخ الحالي في التنسيق المناسب
  static String getDefaultDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd'); // تنسيق التاريخ
    return formatter.format(now);
  }

  // دالة للحصول على تاريخ اليوم مع إضافة عدد من الأيام
  static String getDatePlusDays(int days) {
    var futureDate = DateTime.now().add(Duration(days: days)); // إضافة 10 أيام
    var formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(futureDate);
  }

  static Future<HotelDescription> getAllHotels() async {
    String today = getDefaultDate();
    String futureDate = getDatePlusDays(10); // اليوم الحالي + 10 أيام

    var uri = Uri.https(BaseURL, 'search.json', {
      'api_key':
      "8583831c20a1efc505c2d99555d5b72ffb1b5ba90f23c147f15eca51a9d64885",
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
      "8583831c20a1efc505c2d99555d5b72ffb1b5ba90f23c147f15eca51a9d64885",
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