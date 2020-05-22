import 'dart:async';
import 'dart:math';

import 'package:pixaeroweather/events/location_event.dart';
import 'package:pixaeroweather/services/weather.dart';

class LocationBloc {
  String _currentCity = 'London';
  WeatherModel _currentWeather = WeatherModel();

  final _cityStateController = StreamController<String>();
  StreamSink<String> get _inCity => _cityStateController.sink;
  Stream<String> get currentCity => _cityStateController.stream;

  final _weatherStateController = StreamController<WeatherModel>();
  StreamSink<WeatherModel> get _inWeather => _weatherStateController.sink;
  Stream<WeatherModel> get currentWeather => _weatherStateController.stream;

  final _cityEventController = StreamController<LocationEvent>();
  Sink<LocationEvent> get citySink => _cityEventController.sink;

  LocationBloc() {
    _cityEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(LocationEvent event) {
    if (event is CityUpdate) {
      var rng = new Random();
      _currentCity = rng.nextDouble().toString();
      _inCity.add(_currentCity);
    }
    if (event is LocationUpdate) {
      getCurrentWeather();
      _inWeather.add(_currentWeather);
    }
  }

  void getCurrentWeather() async {
    await _currentWeather.getLocationWeather();
  }

  void dispose() {
    //Important! To prevent memory overflow
    _cityEventController.close();
    _cityStateController.close();
    _weatherStateController.close();
  }
}
