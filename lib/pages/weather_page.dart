import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('b4a74419b64040985e1d0e3f726fd50c');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get the current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

    // weather animations
    String getWeatherAnimation(String? mainCondition) {
      if (mainCondition == null) return 'assets/sunny.json'; // default to sunny

      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/cloud.json';
        case 'rain':
        case 'drizzle':
        case 'shower rain':
          return 'assets/rain.json';
        case 'thunderstorm':
          return 'assets/thunder.json';
        case 'clear':
          return 'assets/sunny.json';
        default:
          return 'assets/sunny.json';
      }
    }

    // init state
  @override
  void initState() {
    super.initState();

    // fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zhumaev Baizak COM 21'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "loading city.."),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperature
            Text('${_weather?.temperature.round()} °C'),

            // weather condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }
}