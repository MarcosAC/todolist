import 'package:flutter/material.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, this.description, this.sizeIcon});

  final String? description;
  final double? sizeIcon;

  @override
  Widget build(BuildContext context) {
    switch (description) {
      case "nublado":
        return Icon(
          Icons.cloud,
          color: Colors.blue,
          size: sizeIcon,
        );
      case "céu limpo":
        return Icon(
          Icons.sunny,
          color: Colors.amber,
          size: sizeIcon,
        );
      case "chuva moderada":
        return Icon(
          Icons.beach_access,
          color: Colors.blue,
          size: sizeIcon,
        );
      default:
        return const CircularProgressIndicator();
    }
  }
}
