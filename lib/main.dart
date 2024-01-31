import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/screens/list_task_screen.dart';
import 'package:todolist/screens/task_form_screen.dart';
import 'package:todolist/utils/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
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
