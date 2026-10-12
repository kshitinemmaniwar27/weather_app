import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  final http.Client _c;

  WeatherService([http.Client? c]) : _c = c ?? http.Client();

  Future<Weather> fetch(String city) async {
    final geoResponse = await _c.get(
      Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
        'name': city,
        'count': '1',
      }),
    );

    final decodedBody = jsonDecode(geoResponse.body);
    final results = decodedBody['results'];
    if (results is! List || results.isEmpty) {
      throw Exception('City not found');
    }

    final place = results.first;
    final weatherResponse = await _c.get(
      Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': '${place['latitude']}',
        'longitude': '${place['longitude']}',
        'current': 'temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code',
        'daily': 'weather_code,temperature_2m_max,temperature_2m_min',
        'timezone': 'auto',
      }),
    );

    if (weatherResponse.statusCode != 200) {
      throw Exception('Server error ${weatherResponse.statusCode}');
    }

    return Weather.fromJson(place['name'] ?? city, jsonDecode(weatherResponse.body));
  }
}

