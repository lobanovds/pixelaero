import 'package:flutter/material.dart';
import 'package:pixaeroweather/bloc/weather_station_bloc.dart';
import 'package:pixaeroweather/bloc/location_bloc.dart';
import 'package:pixaeroweather/events/weather_event.dart';
import 'package:pixaeroweather/events/location_event.dart';
import 'package:pixaeroweather/services/weather.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _weatherBloc = WeatherBloc();
  final _locationBloc = LocationBloc();

  @override
  Widget build(BuildContext context) {
    WeatherModel initWeatherModel = WeatherModel();
    initWeatherModel.getLocationWeather();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () => _locationBloc.citySink.add(LocationUpdate()),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: _locationBloc.currentWeather, //stream,
                initialData: initWeatherModel,
                builder: (BuildContext context,
                    AsyncSnapshot<WeatherModel> snapshot) {
                  return Text(
                    'current City ${snapshot.data.cityName} in lat: ${snapshot.data.coordinates.latitude ?? '0.0'} and long: ${snapshot.data.coordinates.longitude ?? '0.0'}',
                  );
                }),
            StreamBuilder(
                stream: _weatherBloc.currentTemperature, //stream,
                initialData: 0.0,
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  return Text(
                    snapshot.data.toString(),
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _weatherBloc.weatherStationSink.add(WeatherUpdate()),
        tooltip: 'Increment',
        child: Icon(Icons.wb_sunny),
      ),
    );
  }

  @override
  void dispose() {
    //Important! To prevent memory overflow
    _weatherBloc.dispose();
    _locationBloc.dispose();
    super.dispose();
  }
}
//style: Theme.of(context).textTheme.display1,
