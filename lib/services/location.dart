import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;
  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        latitude = position.latitude;
        longitude = position.longitude;
      } else {
        // Handle the case when the user denies the location permission
        throw Exception('Location permissions are denied.');
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}


