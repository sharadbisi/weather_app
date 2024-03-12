import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'model.dart';

class WeatherService {
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
  static const FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast";
  static const String BASE_ICON_URL = 'http://openweathermap.org/img/wn/';


  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<List<WeatherForecast>> getForecast(String cityName) async {
    final response = await http.get(Uri.parse('$FORECAST_URL?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['list'] as List<dynamic>;
      return jsonData.map((data) => WeatherForecast.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load forecast data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].locality;

    return city ?? "";
  }

  String getWeatherIconUrl(String iconCode) {
    return '$BASE_ICON_URL$iconCode@2x.png'; // Assuming 2x resolution icons
  }
}
