import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Tarefa"),
        titleTextStyle: const TextStyle(fontSize: 17),
        actions: [
          IconButton(onPressed: () {
            Task newTask = Task(title: title, time: time)
          }, icon: const Icon(Icons.save)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
        ],        
      ),
      body: const Padding(padding: EdgeInsets.all(8.0)),
    );
  }
}
