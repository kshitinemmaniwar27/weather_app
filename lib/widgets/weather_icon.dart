import 'package:flutter/material.dart';
class WeatherIcon extends StatefulWidget{
const WeatherIcon(this.icon,{super.key,this.size=72});
final IconData icon;final double size;
@override State<WeatherIcon> createState()=>_WeatherIconState();
}
class _WeatherIconState extends State<WeatherIcon> with SingleTickerProviderStateMixin{
late final AnimationController _a=AnimationController(vsync:this,duration:const Duration(seconds:2))..repeat(reverse:true);
late final Animation<double> _s=Tween(begin:0.9,end:1.1).animate(CurvedAnimation(parent:_a,curve:Curves.easeInOut));
@override void dispose(){_a.dispose();super.dispose();}
@override Widget build(BuildContext c)=>ScaleTransition(scale:_s,child:Icon(widget.icon,size:widget.size,color:Theme.of(c).colorScheme.primary));
}
