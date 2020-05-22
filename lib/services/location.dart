import 'package:geolocator/geolocator.dart';
import 'package:pixaeroweather/utilites/coords.dart';

class Location {
  Coordinates coordinates;

  Future<Coordinates> getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    coordinates = Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    return coordinates;
  }
}
