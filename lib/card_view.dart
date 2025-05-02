import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
    required this.iconUrl,
  });
  final String cityName;
  final double temperature;
  final String weatherDescription;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    // Decide the image based on weather condition
    String imageUrl;
    if (weatherDescription.contains('rain')) {
      imageUrl = 'assets/Rainy_Day.jpg'; // Replace with your rainy image path
    } else if (weatherDescription.contains('clear')) {
      imageUrl = 'assets/Sunny_Day.jpg'; // Replace with your sunny image path
    } else if (weatherDescription.contains('cloud')) {
      imageUrl = 'assets/Cloudy_day.jpg'; // Replace with your cloudy image path
    } else if (weatherDescription.contains('storm')) {
      imageUrl =
          'assets/Thunder_Storm.jpg'; // Replace with your cloudy image path
    } else if (weatherDescription.contains('snow')) {
      imageUrl = 'assets/Snowy_day.jpg'; // Replace with your cloudy image path
    } else {
      imageUrl = 'assets/Default.jpg'; // Default image if no condition matches
    }

    return Card(
      color: const Color.fromARGB(255, 71, 101, 253),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners for the card
      ),
      elevation: 5, // Add shadow for better visualization
      margin: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Image.network(
              iconUrl, // Weather icon from the API
              width: 50,
              height: 50,
            ),
            title: Text(
              cityName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            subtitle: Text(
              weatherDescription,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
              child: Text(
                '$temperature°C', // Temperature in Celsius
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 100, // Adjust the height of the image as per your need
            width: double.infinity,
            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imageUrl), // Set the dynamic weather image
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
