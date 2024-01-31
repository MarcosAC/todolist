import 'package:flutter/material.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/utils/database/database_utils.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  Future<void> addTask(Task task) async {
    DataBaseUtils.insert('tasks', task.toMap());
    notifyListeners();
  }

  Future<void> loadTasks() async {
    final listTask = await DataBaseUtils.getAll('tasks');

    _tasks = listTask
        .map((task) => Task(
              id: task['id'],
              title: task['title'],
              time: task['time'],
            ))
        .toList();

    notifyListeners();
  }

  Future<void> updateCharacter(Task task) async {
    int index = _tasks.indexWhere((task) => task.id == task.id);

    if (index >= 0) {
      Task newCharacter = Task(
        id: task.id,
        title: task.title,
        time: task.time,
      );

      DataBaseUtils.update('tasks', newCharacter);
      _tasks[index] = newCharacter;
      notifyListeners();
    }
  }

  Future<void> delete(int id) async {
    var task = taskById(id);
    DataBaseUtils.delete('tasks', task!.id);
    final listTask = await DataBaseUtils.getAll('tasks');
    _tasks = _tasks = listTask
        .map((task) => Task(
              id: task['id'],
              title: task['title'],
              time: task['time'],
            ))
        .toList();
    notifyListeners();
  }

  Task characterByIndex(int index) {
    return _tasks[index];
  }

  Task? taskById(int id) {
    _tasks = listTasks.where((element) => element.id == id).toList();
    Task? newTask;

    for (var task in _tasks) {
      newTask = Task(id: task.id, title: task.title, time: task.time);
    }

    return newTask;
  }

  List<Task> get listTasks {
    return [..._tasks];
  }

  int get itemsCount {
    return _tasks.length;
  }
}
