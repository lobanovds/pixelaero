import 'package:pixaeroweather/services/location.dart';
import 'package:pixaeroweather/services/networking.dart';
import 'package:pixaeroweather/utilites/constants.dart';
import 'package:pixaeroweather/utilites/coords.dart';

class WeatherModel {
  String cityName = '';
  int temperature = 0;
  Coordinates coordinates = Coordinates(latitude: 0.0, longitude: 0.0);

  Future<void> getLocationWeather() async {
    try {
      Location location = Location();
      coordinates = await location.getCurrentLocation();

      NetworkHelper networkHelper = new NetworkHelper(
          '$openWeatherMapURL?lat=${coordinates.latitude}&lon=${coordinates.longitude}&units=metric&appid=$apiKey');
      var weatherData = await networkHelper.getData();

      cityName = weatherData['name'];
      temperature = weatherData['main']['temp'].toDouble().toInt();
    } catch (e) {
      print(e);
    }
  }
}
