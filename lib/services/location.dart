import 'package:geolocator/geolocator.dart';
import 'package:pixaeroweather/utilites/coords.dart';

class Location {
  Future<Coordinates> getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }
}
