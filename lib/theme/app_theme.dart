import 'package:flutter/material.dart';
ThemeData _build(Brightness b){
final s=ColorScheme.fromSeed(seedColor:Colors.blue,brightness:b);
return ThemeData(useMaterial3:true,colorScheme:s,
cardTheme:CardTheme(elevation:3,shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))),
inputDecorationTheme:InputDecorationTheme(border:OutlineInputBorder(borderRadius:BorderRadius.circular(16)),filled:true),
textTheme:const TextTheme(displayLarge:TextStyle(fontSize:64,fontWeight:FontWeight.w300)));}
final lightTheme=_build(Brightness.light);
final darkTheme=_build(Brightness.dark);
