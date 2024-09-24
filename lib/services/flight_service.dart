import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/flight_ticket.dart';

class NewServiceFlight
{
 // var j=0;
  //var k=0;
  final Dio dio;
  NewServiceFlight(this.dio);
  Future <List<FligthTicketModel>>getTicket() async{
    var responce =await dio.get(
      "https://serpapi.com/search.json?engine=google_flights&departure_id=PEK&arrival_id=AUS&outbound_date=2024-09-26&return_date=2024-10-02&currency=USD&hl=en&api_key=8583831c20a1efc505c2d99555d5b72ffb1b5ba90f23c147f15eca51a9d64885"
    );
    Map<String,dynamic> jsonData=responce.data;
    List<dynamic> flights=jsonData['other_flights'];
    //List<dynamic> flightsmin = jsonData['other_flights']['flights'];
    //List<dynamic> miniflights=jsonData["other_flights"][j]["flights"];//
    List<FligthTicketModel> flightlists=[];
    for (var flight in flights){
      List<dynamic> flightsmin = flight['flights'];
      for (var flightmini in flightsmin){
          FligthTicketModel fligthTicketModel=FligthTicketModel(

                 price:flight["price"],
                 namedeparture: flightmini["departure_airport"]["id"],
                 //namedeparturelong: flightmini["departure_airport"]["name"],
                 timedeparture:flightmini["departure_airport"]["time"] ,
          namearrive: flightmini["arrival_airport"]["id"],
          //namearrivelong: flightmini["arrival_airport"]["name"],
           timearrive:flightmini["arrival_airport"]["time"],

          );

         flightlists.add(fligthTicketModel);
          //k++;
        }
      //k=0;
         //k++;


    }
      //j++;
      //miniflights=jsonData["other_flights"][j]["flights"];//
     // k=0;
      //flights=jsonData["other_flights"][k];
    return flightlists;
  }

      }
//  for(var flight in flights){
//      for(var miniflight in flights[flights] ){
// namedeparture: miniflight["departure_airport"]["id"],
// namedeparturelong: miniflight["departure_airport"]["name"],
// timedeparture:miniflight["departure_airport"]["time"] ,
// namearrive: miniflight["arrival_airport"]["id"],
// namearrivelong: miniflight["arrival_airport"]["name"],
// timearrive:miniflight["arrival_airport"]["time"],time
//  flightlists.add(fligthTicketModel);
//
//
//     }
//     return flightlists;
//   }

// FligthTicketModel fligthTicketModel=FligthTicketModel(
//   namedeparture: flight["flights"][0]["departure_airport"]["id"],
//   namedeparturelong: flight["flights"][0]["departure_airport"]["name"],
//   timedeparture:flight["flights"][0]["departure_airport"]["time"] ,
//   namearrive: flight["flights"][0]["arrival_airport"]["id"],
//   namearrivelong: flight["flights"][0]["arrival_airport"]["name"],
//   timearrive: flight["flights"][0]["arrival_airport"]["time"],);
//
//
// flightlists.add(fligthTicketModel);
//
//
