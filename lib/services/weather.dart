import 'package:pixaeroweather/services/location.dart';
import 'package:pixaeroweather/services/networking.dart';
import 'package:pixaeroweather/utilites/constants.dart';
import 'package:pixaeroweather/utilites/coords.dart';

class WeatherModel {
  String cityName = '';
  double temperature = 0.00;
  Coordinates coordinates;

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = new NetworkHelper(
        '$openWeatherMapURL?lat=${location.coordinates.latitude}&lon=${location.coordinates.longitude}&units=metric&appid=$apiKey');
    var weatherData = await networkHelper.getData();
    cityName = weatherData['name'];
    temperature = weatherData['main']['temp'].toDouble().toInt();
    coordinates.latitude = location.coordinates.latitude;
    coordinates.longitude = location.coordinates.longitude;
    return weatherData;
  }
}
