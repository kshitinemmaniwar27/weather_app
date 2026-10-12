import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_card.dart';
import '../widgets/forecast_tile.dart';
class HomeScreen extends StatefulWidget{const HomeScreen({super.key});
@override State<HomeScreen> createState()=>_HomeScreenState();}
class _HomeScreenState extends State<HomeScreen>{
final _key=GlobalKey<FormState>();final _ctrl=TextEditingController();
@override void dispose(){_ctrl.dispose();super.dispose();}
void _go(){if(_key.currentState!.validate())context.read<WeatherProvider>().search(_ctrl.text.trim());}
Widget _form()=>Form(key:_key,child:Row(crossAxisAlignment:CrossAxisAlignment.start,children:[
Expanded(child:TextFormField(controller:_ctrl,textInputAction:TextInputAction.search,onFieldSubmitted:(_)=>_go(),
decoration:const InputDecoration(labelText:'City',prefixIcon:Icon(Icons.search)),
validator:(v){final s=v?.trim()??'';if(s.isEmpty)return 'Enter a city';if(s.length<2)return 'Too short';if(!RegExp(r"^[\p{L}\s.'-]+$",unicode:true).hasMatch(s))return 'Letters only';return null;})),
const SizedBox(width:8),
Padding(padding:const EdgeInsets.only(top:4),child:FilledButton(onPressed:_go,child:const Text('Search')))]));
@override Widget build(BuildContext c){
final p=c.watch<WeatherProvider>();
final w=p.weather;
Widget body;
if(p.loading){body=const Center(child:CircularProgressIndicator());}
else if(p.error!=null){body=Center(child:Text(p.error!,style:TextStyle(color:Theme.of(c).colorScheme.error)));}
else if(w==null){body=const Center(child:Text('Search a city to see the weather'));}
else{
final cur=CurrentCard(w,onTap:()=>Navigator.pushNamed(c,'/detail'));
final days=w.days.map((d)=>ForecastTile(d)).toList();
body=LayoutBuilder(builder:(_,box)=>box.maxWidth>700
?Row(children:[Expanded(flex:2,child:Center(child:cur)),Expanded(flex:3,child:ListView(children:days))])
:ListView(children:[cur,...days]));}
return Scaffold(
appBar:AppBar(title:const Text('Weather'),actions:[IconButton(icon:const Icon(Icons.settings),onPressed:()=>Navigator.pushNamed(c,'/settings'))]),
body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[_form(),const SizedBox(height:12),
Expanded(child:AnimatedSwitcher(duration:const Duration(milliseconds:400),child:KeyedSubtree(key:ValueKey('${p.loading}${w?.city}${p.error}'),child:body)))])));}
}
