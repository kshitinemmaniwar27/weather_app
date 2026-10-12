import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';
import '../widgets/current_card.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final weather = provider.weather;

    if (weather == null || weather.days.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Weather details unavailable')),
      );
    }

    final today = weather.days.first;

    return Scaffold(
      appBar: AppBar(title: Text(weather.city)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CurrentCard(weather),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.water_drop),
                  title: const Text('Humidity'),
                  trailing: Text('${weather.humidity}%'),
                ),
                ListTile(
                  leading: const Icon(Icons.air),
                  title: const Text('Wind'),
                  trailing: Text('${weather.wind} km/h'),
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_upward),
                  title: const Text('Today high'),
                  trailing: Text(provider.t(today.max)),
                ),
                ListTile(
                  leading: const Icon(Icons.arrow_downward),
                  title: const Text('Today low'),
                  trailing: Text(provider.t(today.min)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

