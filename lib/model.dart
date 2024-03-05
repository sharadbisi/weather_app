// class Weather {
//   final String cityName;
//   final double temp;
//   final String mainCondition;
//   final int humidity; // Add a field for humidity
//   final double? rain;// Add a field for precipitation
//   final double? snow;
//   final double? windSpeed;
//   final String icon;
//   // final DateTime dateTime;
   

//   Weather({
//     required this.cityName,
//     required this.temp,
//     required this.mainCondition,
//     required this.humidity, // Initialize it in the constructor
//     this.rain, // Initialized as optional
//     this.snow,
//     this.windSpeed,
//     required this.icon,
//     // required this.dateTime,
//   });

//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       cityName: json['name'],
//       temp: json['main']['temp'].toDouble(),
//       mainCondition: json['weather'][0]['description'],//mainCondition: json['weather'][0]['main'],
//       humidity: json['main']['humidity'], // Get humidity from the JSON
//       rain: json['rain']?['1h'], // Parse rain volume for the last 1 hour if available
//       snow: json['snow']?['1h'],
//       windSpeed: json['wind']['speed'] != null ? (json['wind']['speed'].toDouble() / 0.2777777) : null,
//       icon: json['weather'][0]['icon'],
//       // dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000), // Parse date/time from timestamp
//     );
//   }
// }







//EXP3

class Weather {
  final String cityName;
  final double temp;
  final String mainCondition;
  final int humidity;
  final double? rain;
  final double? snow;
  final double? windSpeed;
  final String icon;
  final List<WeatherForecast> forecasts; // Add a list of forecasts

  Weather({
    required this.cityName,
    required this.temp,
    required this.mainCondition,
    required this.humidity,
    this.rain,
    this.snow,
    this.windSpeed,
    required this.icon,
    required this.forecasts, // Initialize forecasts in the constructor
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      rain: json['rain']?['1h']?.toDouble(),
      snow: json['snow']?['1h']?.toDouble(),
      windSpeed: json['wind']?['speed']?.toDouble(),
      icon: json['weather'][0]['icon'],
      forecasts: [], // Initialize as an empty list for 7 dats forecast
    );
  }
}

class WeatherForecast {
  final DateTime date;
  final double temperature;
  final String condition;
  final double? rain;
  final double? snow;
  final double? windSpeed;
  final String icon;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.condition,
    this.rain,
    this.snow,
    this.windSpeed,
    required this.icon,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.parse(json['dt_txt']), // Assuming 'dt_txt' contains the date
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['description'],
      rain: json['rain']?['1h']?.toDouble(),
      snow: json['snow']?['1h']?.toDouble(),
      windSpeed: json['wind']?['speed']?.toDouble(),
      icon: json['weather'][0]['icon'],
    );
  }
}
