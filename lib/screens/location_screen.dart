import 'package:flutter/material.dart';
import 'package:linkedin8webdata/screens/city_screen.dart';
import 'package:linkedin8webdata/services/weather.dart';
import 'package:linkedin8webdata/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int _temperature = 0;
  String _weatherIcon = "";
  String _cityName = "";
  String _weatherMessage = "";
  WeatherModel _weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        _temperature = 0;
        _weatherIcon = 'Error';
        _weatherMessage = 'Unable to fetch the weather data';
        _cityName = '';
        return;
      }
      double temp = weatherData['main']['temp'];
      _temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      _weatherIcon = _weatherModel.getWeatherIcon(condition);
      _weatherMessage = _weatherModel.getMessage(_temperature);
      _cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData =
                          await WeatherModel().getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedCity = await Navigator.push(context,
                          MaterialPageRoute(builder: (
                        context,
                      ) {
                        return CityScreen();
                      }));
                      if (typedCity != null) {
                        var weatherData =
                            await _weatherModel.getCityWeather(typedCity);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$_temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      _weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$_weatherMessage in $_cityName',
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
