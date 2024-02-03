class Weather {
  String? description;
  double? temperature;

  Weather({
    required this.description,
    required this.temperature,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    description = json['weather'][0]['description'];
    temperature = json['main']['temp'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['temperature'] = temperature;
    return data;
  }
}
