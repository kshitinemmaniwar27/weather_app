import 'package:flutter/material.dart';
class Day{final DateTime date;final double max,min;final int code;Day(this.date,this.max,this.min,this.code);}
class Weather{
final String city;final double temp,wind;final int humidity,code;final List<Day> days;
Weather(this.city,this.temp,this.wind,this.humidity,this.code,this.days);
factory Weather.fromJson(String city,Map<String,dynamic> j){
final c=j['current'],d=j['daily'];
return Weather(city,(c['temperature_2m'] as num).toDouble(),(c['wind_speed_10m'] as num).toDouble(),(c['relative_humidity_2m'] as num).toInt(),c['weather_code'] as int,
List.generate((d['time'] as List).length,(i)=>Day(DateTime.parse(d['time'][i]),(d['temperature_2m_max'][i] as num).toDouble(),(d['temperature_2m_min'][i] as num).toDouble(),d['weather_code'][i] as int)));}
}
String describe(int c)=>c==0?'Clear':c<4?'Cloudy':c<50?'Fog':c<70?'Rain':c<80?'Snow':c<90?'Showers':'Thunderstorm';
IconData iconFor(int c)=>c==0?Icons.wb_sunny:c<4?Icons.cloud:c<50?Icons.foggy:c<70?Icons.grain:c<80?Icons.ac_unit:c<90?Icons.umbrella:Icons.thunderstorm;
