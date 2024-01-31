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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                label: Text("Tarefa"),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                label: Text("Hora"),
                contentPadding: EdgeInsets.all(10),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  Task newTask = Task(title: _titleController.text, time: _timeController.text);
                  Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                },
                child: const Text("Adicionar Tarefa")),
          ],
        ),
      ),
    );
  }
}
