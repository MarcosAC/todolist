import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/provider/weather_provider.dart';
import 'package:todolist/screens/list_task_screen.dart';
import 'package:todolist/screens/task_form_screen.dart';
import 'package:todolist/services/weather_service.dart';
import 'package:todolist/utils/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final WeatherService weatherService = WeatherService(apiKey: "");

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider(weatherService)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ListTaskScreen(),
        routes: {
          AppRoutes.taskFormScreen: (context) => const TaskFormScreen(),
          AppRoutes.listTaskScreen: (context) => const ListTaskScreen(),
        },
      ),
    );
  }
}
