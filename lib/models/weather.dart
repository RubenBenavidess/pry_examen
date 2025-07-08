class WeatherData {
  final String city;
  final double temperature;
  final String description;
  final String icon;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
    );
  }
}
