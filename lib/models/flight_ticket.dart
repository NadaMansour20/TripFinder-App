class FligthTicketModel{
  final String? namedeparture;
  //final String? namedeparturelong;
  final String? timedeparture;
  final String? namearrive;
  //final String? namearrivelong;
  final String? timearrive;
  final int? price;
  FligthTicketModel(
  {required this.namedeparture,required this.timedeparture
  ,required this.namearrive,required this.timearrive, required this.price}
      );

}
// FligthTicketModel(
//     {required this.namedeparture,required this.namedeparturelong,required this.timedeparture
//       ,required this.namearrive,required this.namearrivelong,required this.timearrive, required this.price}
//     );