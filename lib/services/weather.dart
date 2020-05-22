import 'package:pixaeroweather/services/location.dart';
import 'package:pixaeroweather/services/networking.dart';
import 'package:pixaeroweather/utilites/constants.dart';
import 'package:pixaeroweather/utilites/coords.dart';

class WeatherModel {
  String cityName = '';
  int temperature;
  Coordinates coordinates;

  Future<void> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      NetworkHelper networkHelper = new NetworkHelper(
          '$openWeatherMapURL?lat=${location.coordinates.latitude}&lon=${location.coordinates.longitude}&units=metric&appid=$apiKey');
      var weatherData = await networkHelper.getData();

      cityName = weatherData['name'];
      temperature = weatherData['main']['temp'].toDouble().toInt();
      coordinates = Coordinates(
          longitude: location.coordinates.longitude,
          latitude: location.coordinates.latitude);
    } catch (e) {
      print(e);
    }
  }
}
