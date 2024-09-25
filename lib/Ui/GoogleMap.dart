import 'package:url_launcher/url_launcher.dart';

class GoogleMap {
  static Future<void> openMap(double latitude, double longitude) async {
    final Uri googleMapUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (await canLaunch(googleMapUrl.toString())) {
      await launchUrl(googleMapUrl);
    } else {
      throw 'Could not launch $googleMapUrl';
    }
  }
}
