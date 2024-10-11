import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

class LocationButton extends StatelessWidget {
  final double latitude;
  final double longitude;

  LocationButton({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[200]),
      onPressed: () async {
        final availableMaps = await MapLauncher.installedMaps;

        // اختيار أول تطبيق خرائط متاح
        final selectedMap = availableMaps.first;

        // فتح تطبيق الخرائط مع الإحداثيات
        await selectedMap.showMarker(
          coords: Coords(latitude, longitude),
          title: "Location",
        );
      },
      child: Text(
        "GPS",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}