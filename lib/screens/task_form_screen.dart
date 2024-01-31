import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/utils/routes/app_routes.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreen();
}

class _TaskFormScreen extends State<TaskFormScreen> {
  final _titleController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Tarefa"),
        titleTextStyle: const TextStyle(fontSize: 17),
        actions: [
          IconButton(
              onPressed: () {
                Task newTask = Task(title: _titleController.text, time: _timeController.text);
                Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
              },
              icon: const Icon(Icons.save)),
          IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(AppRoutes.listTaskScreen);
              },
              icon: const Icon(Icons.list)),
        ],
      ),
      body: const Padding(padding: EdgeInsets.all(8.0)),
    );
  }
}
