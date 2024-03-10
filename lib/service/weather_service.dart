import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:minimal_weather_app/model/weather_model.dart';

class WeatherService {
  bool noService = false;
  static const baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(String cityName) async {
    final response =
        await http.get(Uri.parse('$baseURL?q=$cityName&appid=$apiKey'));
    if (response.statusCode == 200) {
      return Weather.fromMap(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      noService = true;
      return getWeather('London');
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    // log(position.latitude.toString());
    // log(position.longitude.toString());

    String? city = placemarks[0].locality;
    // log(city.toString());

    return city ?? "";
  }
}
