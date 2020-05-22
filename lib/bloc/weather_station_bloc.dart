import 'dart:async';
import 'dart:math';

import 'package:pixaeroweather/events/weather_event.dart';

class WeatherBloc {
  double _currentTemperature = 0.00;

  final _temperatureStateController = StreamController<double>();
  StreamSink<double> get _inTemperature => _temperatureStateController.sink;
  Stream<double> get currentTemperature => _temperatureStateController.stream;

  final _temperatureEventController = StreamController<WeatherStationEvent>();
  Sink<WeatherStationEvent> get weatherStationSink =>
      _temperatureEventController.sink;

  WeatherBloc() {
    _temperatureEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(WeatherStationEvent event) {
    if (event is WeatherUpdate) {
      _currentTemperature = new Random().nextDouble();
      _inTemperature.add(_currentTemperature);
    }
  }

  void dispose() {
    //Important! To prevent memory overflow
    _temperatureEventController.close();
    _temperatureStateController.close();
  }
}
