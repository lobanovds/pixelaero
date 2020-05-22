import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pixaeroweather/bloc/weather_bloc.dart';
import 'package:pixaeroweather/events/weather_event.dart';
import 'package:pixaeroweather/services/weather.dart';

const timeout = const Duration(seconds: 3);
const ms = const Duration(milliseconds: 1);

class LocationScreen extends StatefulWidget {
  LocationScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LocationScreen createState() => _LocationScreen();
}

class _LocationScreen extends State<LocationScreen> {
  WeatherModel initWeatherModel;

  Timer _timer;

  @override
  void initState() {
    super.initState();
    initWeatherModel = WeatherModel();
    _timer = Timer.periodic(Duration(seconds: 1),
        (_) => _locationBloc.citySink.add(LocationUpdate()));
  }

  final _locationBloc = WeatherBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () => _locationBloc.citySink.add(LocationUpdate()),
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: _locationBloc.currentWeather, //stream,
            initialData: initWeatherModel,
            builder:
                (BuildContext context, AsyncSnapshot<WeatherModel> snapshot) {
              if (snapshot.data != null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'current City ${snapshot.data.cityName ?? ''} ',
                    ),
                    Text(
                      'in lat: ${snapshot.data.coordinates.latitude ?? '0.0'}',
                    ),
                    Text(
                      'and long: ${snapshot.data.coordinates.longitude ?? '0.0'}',
                    ),
                    Text(
                      'Temperature ${snapshot.data.temperature ?? -100}',
                    )
                  ],
                );
              } else
                return Column(children: <Widget>[
                  Text(
                    'current City --- ',
                  ),
                  Text(
                    'in lat: 0.0',
                  ),
                  Text(
                    'and long: 0.0',
                  ),
                  Text(
                    'Temperature  -100}',
                  )
                ]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _locationBloc.citySink.add(LocationUpdate()),
        tooltip: 'Increment',
        child: Icon(Icons.wb_sunny),
      ),
    );
  }

  @override
  void dispose() {
    //Important! To prevent memory overflow
    _locationBloc.dispose();
    _timer.cancel();
    super.dispose();
  }
}
