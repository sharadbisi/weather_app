import 'dart:convert'; // This is necessary for jsonDecode
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

class WeatherService {
  // It's better to name constants with a full uppercase to follow Dart conventions
  static const BASE_URL = "http://api.openweathermap.org/data/2.5/weather";
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



  Future<String> getCurrentCity()  async{
    //get permission from user
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    //convert the location into a list of placemark object
    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    //exctract the city name from the first placemark
    String? city = placemarks[0].locality;

    return city ?? "";
  }

Future<List<Weather>> getForecast(String cityName) async {
  final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    print('Forecast API Response: $jsonData'); // Log the response for debugging

    // Parse the response JSON and extract forecast data...
    // Your existing code to parse the response and create a list of Weather objects
  } else {
    print('Failed to fetch forecast data. Status code: ${response.statusCode}');
    throw Exception('Failed to load forecast data');
  }
  throw Error();
}

  // Future<List<Weather>> getForecast(String cityName) async {
  //   final response = await http.get(Uri.parse('$BASE_URL/forecast?q=$cityName&appid=$apiKey&units=metric'));

  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonList = jsonDecode(response.body)['list'];
  //     return jsonList.map((json) => Weather.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to load forecast data');
  //   }
  // }

}
