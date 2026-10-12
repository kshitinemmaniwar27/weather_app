import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/weather.dart';
import '../providers/weather_provider.dart';
import 'weather_icon.dart';
class CurrentCard extends StatelessWidget{
const CurrentCard(this.w,{super.key,this.onTap});
final Weather w;final VoidCallback? onTap;
@override Widget build(BuildContext c){
final p=c.watch<WeatherProvider>();
return Hero(tag:'current',child:Material(type:MaterialType.transparency,child:Card(child:InkWell(borderRadius:BorderRadius.circular(20),onTap:onTap,child:Padding(padding:const EdgeInsets.all(24),child:Column(children:[
Text(w.city,style:Theme.of(c).textTheme.headlineMedium),
WeatherIcon(iconFor(w.code)),
TweenAnimationBuilder<double>(tween:Tween(begin:0,end:1),duration:const Duration(milliseconds:700),builder:(_,v,child)=>Opacity(opacity:v,child:child),child:Text(p.t(w.temp),style:Theme.of(c).textTheme.displayLarge)),
Text(describe(w.code),style:Theme.of(c).textTheme.titleMedium),
]))))));}
}
