import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';

class WeatherService {
  static const String _apiKey = '32518fecd8d3b0c2470b0dfbde97f7ad';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  // Mapa de ciudades con sus coordenadas (latitud y longitud)
  static final Map<String, Map<String, double>> _cityCoordinates = {
    'Quito': {'lat': -0.22985, 'lon': -78.52495}, // Coordenadas de Quito, Ecuador
    'Guayaquil': {'lat': -2.19616, 'lon': -79.88621}, // Coordenadas de Guayaquil, Ecuador
    'Cuenca': {'lat': -2.90055, 'lon': -79.00453}, // Coordenadas de Cuenca, Ecuador
    'Ambato': {'lat': -1.24213, 'lon': -78.61678}, // Coordenadas de Ambato, Ecuador
    'Loja': {'lat': -3.99313, 'lon': -79.20427}, // Coordenadas de Loja, Ecuador
  };

  static Future<List<WeatherData>> getWeatherForCities(List<String> cities) async {
    List<WeatherData> weatherList = [];

    for (String city in cities) {
      try {
        final coordinates = _cityCoordinates[city];

        if (coordinates != null) {
          final lat = coordinates['lat'];
          final lon = coordinates['lon'];

          final response = await http.get(
            Uri.parse('$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric&lang=es'),
          );

          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            weatherList.add(WeatherData.fromJson(data));
          } else {
            print('Error en la API del clima para $city (Código: ${response.statusCode}, Cuerpo: ${response.body})');
            weatherList.add(WeatherData(
              city: city,
              temperature: 15.0 + (cities.indexOf(city) * 3),
              description: 'Clima simulado (Error API: ${response.statusCode})',
              icon: '01d',
            ));
          }
        } else {
          print('Coordenadas no disponibles para $city. Agregando datos de prueba.');
          weatherList.add(WeatherData(
            city: city,
            temperature: 18.0 + (cities.indexOf(city) * 2),
            description: 'Sin coordenadas definidas - datos de prueba',
            icon: '01d',
          ));
        }
      } catch (e) {
        print('Excepción al procesar $city: $e');
        weatherList.add(WeatherData(
          city: city,
          temperature: 18.0 + (cities.indexOf(city) * 2),
          description: 'Error de conexión/parsing - datos de prueba',
          icon: '01d',
        ));
      }
    }

    return weatherList;
  }
}
