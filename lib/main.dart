import 'package:flutter/material.dart';
import 'package:pixaeroweather/bloc/weather_bloc.dart';
import 'package:pixaeroweather/events/weather_event.dart';
import 'package:pixaeroweather/services/weather.dart';

void main() => runApp(MyApp());

WeatherModel initWeatherModel;

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
  @override
  void initState() {
    super.initState();
    initWeatherModel = WeatherModel();
    initWeatherModel.getLocationWeather();
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'current City ${snapshot.data.cityName} ',
                  ),
                  Text(
                    'in lat: ${snapshot.data.coordinates.latitude ?? '0.0'}',
                  ),
                  Text(
                    'and long: ${snapshot.data.coordinates.longitude ?? '0.0'}',
                  ),
                  Text(
                    'Temperature ${snapshot.data.temperature}',
                  )
                ],
              );
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
    super.dispose();
  }
}
//style: Theme.of(context).textTheme.display1,
