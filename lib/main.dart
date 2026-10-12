import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'screens/detail_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'services/weather_service.dart';
import 'theme/app_theme.dart';
void main()=>runApp(WeatherApp(service:WeatherService()));
class WeatherApp extends StatelessWidget{
const WeatherApp({super.key,required this.service});
final WeatherService service;
Route _route(RouteSettings s){
final page=switch(s.name){'/detail'=>const DetailScreen(),'/settings'=>const SettingsScreen(),_=>const HomeScreen()};
if(s.name=='/')return MaterialPageRoute(settings:s,builder:(_)=>page);
return PageRouteBuilder(settings:s,pageBuilder:(_,__,___)=>page,transitionsBuilder:(_,a,__,child)=>SlideTransition(position:Tween(begin:const Offset(1,0),end:Offset.zero).animate(CurvedAnimation(parent:a,curve:Curves.easeOut)),child:child));}
@override Widget build(BuildContext c)=>ChangeNotifierProvider(create:(_)=>WeatherProvider(service),
child:Consumer<WeatherProvider>(builder:(_,p,__)=>MaterialApp(title:'Weather App',debugShowCheckedModeBanner:false,theme:lightTheme,darkTheme:darkTheme,themeMode:p.mode,initialRoute:'/',onGenerateRoute:_route)));
}
