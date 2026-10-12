import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../providers/weather_provider.dart';
class ForecastTile extends StatelessWidget{
const ForecastTile(this.d,{super.key});
final Day d;
static const _n=['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
@override Widget build(BuildContext c){
final p=c.watch<WeatherProvider>();
return Card(child:ListTile(leading:Icon(iconFor(d.code)),title:Text('${_n[d.date.weekday-1]} ${d.date.day}/${d.date.month}'),subtitle:Text(describe(d.code)),trailing:Text('${p.t(d.max)} / ${p.t(d.min)}')));}
}
