import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';
class WeatherService{
final http.Client _c;
WeatherService([http.Client? c]):_c=c??http.Client();
Future<Weather> fetch(String city)async{
final g=await _c.get(Uri.https('geocoding-api.open-meteo.com','/v1/search',{'name':city,'count':'1'}));
final r=jsonDecode(g.body)['results'];
if(r==null)throw Exception('City not found');
final p=r[0];
final w=await _c.get(Uri.https('api.open-meteo.com','/v1/forecast',{'latitude':'${p['latitude']}','longitude':'${p['longitude']}','current':'temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code','daily':'weather_code,temperature_2m_max,temperature_2m_min','timezone':'auto'}));
if(w.statusCode!=200)throw Exception('Server error ${w.statusCode}');
return Weather.fromJson(p['name'],jsonDecode(w.body));}
}
