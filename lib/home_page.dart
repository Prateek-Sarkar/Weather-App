import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/card_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _cityController =
      TextEditingController(); // To capture city name input
  double? temperature;
  String? weatherDescription;
  String? weatherIconUrl;
  String? city;

  // Function to fetch weather data when search is clicked
  void _searchWeather() {
    String cityName = _cityController.text.trim();
    if (cityName.isNotEmpty) {
      fetchWeather(cityName);
    }
  }

  // Fetch weather data and update state
  bool isLoading = false;

  Future<void> fetchWeather(String cityName) async {
    setState(() {
      isLoading = true;
    });

    final apiKey =
        'e4f943980f1ba4e50b62c5df44ed948f'; // Your OpenWeatherMap API key
    ;
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['main']['temp'];
        final description = data['weather'][0]['description'];
        final iconCode = data['weather'][0]['icon'];
        final iconUrl = 'https://openweathermap.org/img/wn/$iconCode@2x.png';

        setState(() {
          temperature = temp.toDouble();
          weatherDescription = description;
          weatherIconUrl = iconUrl;
          city = data['name'];
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('City not found')));
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Exception: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Column(
        children: [
          // Search input and button
          Container(
            margin: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        _cityController, // Text field to input city name
                    decoration: InputDecoration(
                      labelText: 'Enter city name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 21, 4, 255),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: _searchWeather, // Trigger search when clicked
                    icon: Icon(Icons.search),
                  ),
                ),
              ],
            ),
          ),

          // Show the card only when weather data is available
          if (temperature != null &&
              weatherDescription != null &&
              weatherIconUrl != null &&
              city != null)
            CardView(
              cityName: city!,
              temperature: temperature!,
              weatherDescription: weatherDescription!,
              iconUrl: weatherIconUrl!,
            ),
        ],
      ),
    );
  }
}
