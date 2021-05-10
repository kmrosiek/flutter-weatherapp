import 'package:linkedin8webdata/services/location.dart';
import 'package:linkedin8webdata/services/networking.dart';

class WeatherModel {
  NetworkHelper networkHelper = NetworkHelper();

  Future<dynamic> getCityWeather(String city) async {
    var weatherData = await networkHelper.getData({'q': city});
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getLocation();
    var weatherData = await networkHelper.getData({
      'lat': location.latitude.toString(),
      'lon': location.longitude.toString()
    });

    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
