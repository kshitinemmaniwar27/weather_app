import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
class SettingsScreen extends StatelessWidget{const SettingsScreen({super.key});
@override Widget build(BuildContext c){
final p=c.watch<WeatherProvider>();
return Scaffold(appBar:AppBar(title:const Text('Settings')),body:ListView(children:[
SwitchListTile(title:const Text('Use Celsius'),value:p.celsius,onChanged:p.toggleUnit),
const ListTile(title:Text('Theme')),
for(final m in ThemeMode.values)RadioListTile<ThemeMode>(title:Text(m.name),value:m,groupValue:p.mode,onChanged:(v)=>p.setMode(v!))]));}
}
