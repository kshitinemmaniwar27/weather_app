import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/services/weather_service.dart';
WeatherService fake()=>WeatherService(MockClient((r)async{
if(r.url.host.startsWith('geocoding'))return http.Response(jsonEncode({'results':[{'name':'Delhi','latitude':28.6,'longitude':77.2}]}),200);
return http.Response(jsonEncode({'current':{'temperature_2m':30.4,'relative_humidity_2m':50,'wind_speed_10m':8.0,'weather_code':0},
'daily':{'time':['2026-10-12','2026-10-13'],'temperature_2m_max':[33.0,34.0],'temperature_2m_min':[22.0,23.0],'weather_code':[0,61]}}),200);}));
void main(){
test('service parses API response',()async{
final w=await fake().fetch('Delhi');
expect(w.city,'Delhi');expect(w.days.length,2);expect(w.humidity,50);});
testWidgets('empty city shows validation error',(t)async{
await t.pumpWidget(WeatherApp(service:fake()));
await t.tap(find.text('Search'));await t.pump();
expect(find.text('Enter a city'),findsOneWidget);});
testWidgets('valid search shows weather and opens settings',(t)async{
await t.pumpWidget(WeatherApp(service:fake()));
await t.enterText(find.byType(TextFormField),'Delhi');
await t.tap(find.text('Search'));await t.pump();await t.pump(const Duration(seconds:1));
expect(find.text('Delhi'),findsWidgets);
await t.tap(find.byIcon(Icons.settings));await t.pumpAndSettle();
expect(find.text('Use Celsius'),findsOneWidget);});
}
