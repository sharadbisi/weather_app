class Weather {
  final String cityName;
  final double temp;
  final String mainCondition;
  final int humidity; // Add a field for humidity
  final double? rain;// Add a field for precipitation
  final double? snow;
  final double? windSpeed;
  final String icon;
  // final DateTime dateTime;
   

  Weather({
    required this.cityName,
    required this.temp,
    required this.mainCondition,
    required this.humidity, // Initialize it in the constructor
    this.rain, // Initialized as optional
    this.snow,
    this.windSpeed,
    required this.icon,
    // required this.dateTime,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temp: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['description'],//mainCondition: json['weather'][0]['main'],
      humidity: json['main']['humidity'], // Get humidity from the JSON
      rain: json['rain']?['1h'], // Parse rain volume for the last 1 hour if available
      snow: json['snow']?['1h'],
      windSpeed: json['wind']['speed'] != null ? (json['wind']['speed'].toDouble() / 0.2777777) : null,
      icon: json['weather'][0]['icon'],
      // dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000), // Parse date/time from timestamp
    );
  }
}
