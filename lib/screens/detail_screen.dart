import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_card.dart';
class DetailScreen extends StatelessWidget{const DetailScreen({super.key});
@override Widget build(BuildContext c){
final p=c.watch<WeatherProvider>();final w=p.weather!;
return Scaffold(appBar:AppBar(title:Text(w.city)),body:ListView(padding:const EdgeInsets.all(16),children:[
CurrentCard(w),
Card(child:Column(children:[
ListTile(leading:const Icon(Icons.water_drop),title:const Text('Humidity'),trailing:Text('${w.humidity}%')),
ListTile(leading:const Icon(Icons.air),title:const Text('Wind'),trailing:Text('${w.wind} km/h')),
ListTile(leading:const Icon(Icons.arrow_upward),title:const Text('Today high'),trailing:Text(p.t(w.days.first.max))),
ListTile(leading:const Icon(Icons.arrow_downward),title:const Text('Today low'),trailing:Text(p.t(w.days.first.min)))]))]));}
}
