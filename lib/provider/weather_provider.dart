import 'package:flutter/material.dart';
import 'package:todolist/models/weather.dart';
import 'package:todolist/services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  Weather? _weather;
  final WeatherService _weatherService;

  WeatherProvider(this._weatherService);

  Weather? get weather => _weather;

  Future<void> fetchWeather(DateTime dateTime, double latitude, double longitude) async {
    try {
      _weather = await _weatherService.getWeather(dateTime, latitude, longitude);
      notifyListeners();
    } catch (e) {
      print('Erro ao obter dados do clima: $e');
    }
  }
}
