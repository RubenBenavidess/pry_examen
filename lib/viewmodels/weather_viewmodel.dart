import 'package:flutter/foundation.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';

class WeatherViewModel extends ChangeNotifier {
  List<WeatherData> _weatherList = [];
  bool _isLoading = false;
  String _error = '';

  List<WeatherData> get weatherList => _weatherList;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadWeatherData() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      final cities = ['Quito', 'Guayaquil', 'Cuenca', 'Ambato', 'Loja'];
      _weatherList = await WeatherService.getWeatherForCities(cities);
    } catch (e) {
      _error = 'Error al cargar los datos del clima';
    }

    _isLoading = false;
    notifyListeners();
  }
}
