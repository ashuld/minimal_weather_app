import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:minimal_weather_app/model/weather_model.dart';
import 'package:minimal_weather_app/service/weather_service.dart';

class ScreenWeather extends StatefulWidget {
  const ScreenWeather({super.key});

  @override
  State<ScreenWeather> createState() => _ScreenWeatherState();
}

class _ScreenWeatherState extends State<ScreenWeather> {
  //api key
  final _weatherService =
      WeatherService(apiKey: '3b0a6c926840da07bcb1561c6de01f30');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async {
    //get current city
    String cityName = await _weatherService.getCurrentCity();

    //get weather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      log(e.toString());
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/animation/sunny.json';
    }
    switch (mainCondition) {
      case 'fog':
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
        return 'assets/animation/cloud.json';
      case 'shower rain':
      case 'rain':
      case 'drizzle':
        return 'assets/animation/rain.json';
      case 'thunderstorm':
        return 'assets/animation/thunder.json';
      case 'clear':
        return 'assets/animation/sunny.json';
      default:
        return 'assets/animation/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? 'loading ..',
              style: const TextStyle(fontSize: 40),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C',
                style: const TextStyle(fontSize: 25)),
            Text(_weather?.mainCondition ?? '',
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
