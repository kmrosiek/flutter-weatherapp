import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper();

  Future getData(Map<String, dynamic> properties) async {
    //var url = Uri.http('api.openweathermap.org', '/data/2.5/weather',
    //{'q': 'barcelona', 'appid': '59ef3ab1236d5ab625133099df96d128'});
    properties['appid'] = '59ef3ab1236d5ab625133099df96d128';
    properties['units'] = 'metric';
    var url = Uri.http(
      'api.openweathermap.org',
      '/data/2.5/weather',
      properties,
    );
    http.Response response = await http.get(url);
    const int STATUS_OK = 200;
    if (response.statusCode == STATUS_OK) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
