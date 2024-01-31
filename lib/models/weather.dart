class Weather {
  String? condition;
  double? temperature;

  Weather({
    required this.condition,
    required this.temperature,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    condition = json['weather'][0]['main'];
    temperature = json['main']['temp'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['condition'] = condition;
    data['temperature'] = temperature;
    return data;
  }

  // final DateTime dateTime;
  // final String condition;
  // final double temperature;
  // final double humidity;
  // final double windSpeed;

  // Weather({
  //   required this.dateTime,
  //   required this.condition,
  //   required this.temperature,
  //   required this.humidity,
  //   required this.windSpeed,
  // });

  // Weather.fromJson(Map<String, dynamic> json) {
  //   condition = json['weather'][0]['main'];
  //   temperature = json['main']['temp'].toDouble();
  // }

  // factory Weather.fromJson(Map<String, dynamic> json) {
  //   return Weather(
  //     dateTime: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: true),
  //     condition: json['weather'][0]['main'],
  //     temperature: json['main']['temp'].toDouble(),
  //     humidity: json['main']['humidity'].toDouble(),
  //     windSpeed: json['wind']['speed'].toDouble(),
  //   );
  // }
}
