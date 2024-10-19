import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../models/flight_ticket.dart';

class NewServiceFlight {
  final Dio dio;

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

  NewServiceFlight(this.dio);

  Future<List<FligthTicketModel>> getTicket() async {
    String today = getDefaultDate();
    String futureDate = getDatePlusDays(10);


    var response = await dio.get(
      "https://serpapi.com/search.json?engine=google_flights&departure_id=PEK&arrival_id=AUS&outbound_date=$today&return_date=$futureDate&currency=USD&hl=en&api_key=f8deb06e89f6b626f7e49e800ae2f173a11e6a1f2d8b6f7bbff7cc143f430711",
    );

    Map<String, dynamic> jsonData = response.data;
    List<dynamic> flights = jsonData['other_flights'];
    List<FligthTicketModel> flightLists = [];

    for (var flight in flights) {
      List<dynamic> flightsMin = flight['flights'];
      for (var flightMini in flightsMin) {
        FligthTicketModel fligthTicketModel = FligthTicketModel(
            price: flight["price"],
            namedeparture: flightMini["departure_airport"]["id"]?? 'Unknown',
            namedeparturelong: flightMini["departure_airport"]["name"]?? 'Unknown',
            namearrivelong: flightMini["arrival_airport"]["name"]?? 'Unknown',
            timedeparture: flightMini["departure_airport"]["time"]?? 'Unknown',
            namearrive: flightMini["arrival_airport"]["id"]?? 'Unknown',
            timearrive: flightMini["arrival_airport"]["time"]?? 'Unknown',
            duration: flightMini["duration"]
        );

        flightLists.add(fligthTicketModel);
      }
    }

    return flightLists;
  }
  //required String from,required String to

  Future<List<FligthTicketModel>> getspecialTicket({required String departureid,
    required String arrivalidid}) async {
    String today = getDefaultDate();
    String futureDate = getDatePlusDays(10);


    var response = await dio.get(
      "https://serpapi.com/search.json?engine=google_flights&departure_id=$departureid&arrival_id=$arrivalidid&outbound_date=$today&return_date=$futureDate&currency=USD&hl=en&api_key=f8deb06e89f6b626f7e49e800ae2f173a11e6a1f2d8b6f7bbff7cc143f430711",
    );

    Map<String, dynamic> jsonData = response.data;
    List<dynamic> flights = jsonData['other_flights'];
    List<FligthTicketModel> flightLists = [];

    for (var flight in flights) {
      List<dynamic> flightsMin = flight['flights'];
      for (var flightMini in flightsMin) {
        FligthTicketModel fligthTicketModel = FligthTicketModel(
            price: flight["price"],
            namedeparture: flightMini["departure_airport"]["id"]?? 'Unknown',
            namedeparturelong: flightMini["departure_airport"]["name"]?? 'Unknown',
            namearrivelong: flightMini["arrival_airport"]["name"]?? 'Unknown',
            timedeparture: flightMini["departure_airport"]["time"]?? 'Unknown',
            namearrive: flightMini["arrival_airport"]["id"]?? 'Unknown',
            timearrive: flightMini["arrival_airport"]["time"]?? 'Unknown',
            duration: flightMini["duration"],
            airportModel: AirportModel.fromJson(response.data)

        );

        flightLists.add(fligthTicketModel);
      }
    }

    return flightLists;
  }
}