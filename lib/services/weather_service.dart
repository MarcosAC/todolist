import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:todolist/models/weather.dart';

class WeatherService {
  final String apiKey;
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  WeatherService({required this.apiKey});

  Future<Weather> getWeather(DateTime dateTime, double latitude, double longitude) async {
    final formattedDateTime = DateFormat('yyyyMMdd').format(dateTime);

    String date = formattedDateTime.toString();

    final url = "$baseUrl?lat=$latitude&lon=$longitude&dt=$date&appid=$apiKey&lang=pt_br&units=metric";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception("Falha ao carregar dados do clima");
    }
  }
}
