class FligthTicketModel{
  final String? namedeparture;
  final String? namedeparturelong;
  final String? timedeparture;
  final String? namearrive;
  final String? namearrivelong;
  final String? timearrive;
  final int? price;
  final int? duration;
  final AirportModel? airportModel;
  FligthTicketModel(
      {required this.namedeparture,required this.timedeparture,required this.namedeparturelong,
        required this.namearrivelong, required this.duration
        ,required this.namearrive,required this.timearrive, required this.price, this.airportModel}
      );

}
// FligthTicketModel(
//     {required this.namedeparture,required this.namedeparturelong,required this.timedeparture
//       ,required this.namearrive,required this.namearrivelong,required this.timearrive, required this.price}
//     );
class AirportModel{
  final String? nameCountrydeparture;
  final String? imageCountrydeparture;
  final String? namecitydeparture;
  final String? namecityarrive;
  final String? nameCountryarrive;
  final String? imageCountryarrive;
  AirportModel( {
    required this.namecitydeparture,
    required this.namecityarrive,
    required this.nameCountrydeparture,
    required this.imageCountrydeparture,
    required  this.nameCountryarrive,
    required this.imageCountryarrive,}
      );
  factory AirportModel.fromJson(json){
    return AirportModel(
        nameCountrydeparture: json["airports"][0]["departure"][0]["country"],
        imageCountrydeparture: json["airports"][0]["departure"][0]["thumbnail"],
        namecitydeparture: json["airports"][0]["departure"][0]["city"],
        namecityarrive: json["airports"][0]["arrival"][0]["city"],
        nameCountryarrive:  json["airports"][0]["arrival"][0]["country"],//arrival"
        imageCountryarrive: json["airports"][0]["arrival"][0]["thumbnail"]
    );

  }
}