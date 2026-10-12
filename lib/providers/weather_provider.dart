import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
class WeatherProvider extends ChangeNotifier{
WeatherProvider(this.service);
final WeatherService service;
Weather? weather;String? error;bool loading=false,celsius=true;ThemeMode mode=ThemeMode.system;
Future<void> search(String city)async{
loading=true;error=null;notifyListeners();
try{weather=await service.fetch(city);}
on Exception catch(e){error=e.toString().replaceFirst('Exception: ','');}
catch(_){error='Check your internet connection';}
loading=false;notifyListeners();}
void toggleUnit(bool v){celsius=v;notifyListeners();}
void setMode(ThemeMode m){mode=m;notifyListeners();}
String t(double c)=>celsius?'${c.round()}°C':'${(c*9/5+32).round()}°F';
}
