import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/provider/weather_provider.dart';
import 'package:todolist/services/weather_service.dart';
import 'package:todolist/utils/routes/app_routes.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key, this.task});

  final Task? task;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreen();
}

class _TaskFormScreen extends State<TaskFormScreen> {
  final WeatherService _weatherService = WeatherService(apiKey: "de8f1c2567a1f497d34639f0a85443c2");

  final _titleController = TextEditingController();
  final _dateController = MaskedTextController(mask: "00/00/0000");
  final _timeController = MaskedTextController(mask: "00:00");

  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final WeatherProvider weatherProvider = Provider.of<WeatherProvider>(context);

    setState(() {
      if (widget.task != null) {
        isEdit = true;

        _titleController.text = widget.task!.title;
        _dateController.text = widget.task!.date;
        _timeController.text = widget.task!.time;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar Tarefa"),
        titleTextStyle: const TextStyle(fontSize: 17),
        actions: [
          IconButton(
              onPressed: () {
                Task newTask = Task(
                  id: widget.task?.id,
                  title: _titleController.text,
                  date: _dateController.text,
                  time: _timeController.text,
                );

                if (isEdit) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertDialog(title: const Text('Editar Tarefa'), content: const Text('Deseja editar tarefa?'), actions: [
                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                            TextButton(
                                onPressed: () {
                                  try {
                                    Provider.of<TaskProvider>(context, listen: false).updateTask(newTask);
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) => AlertDialog(
                                                title: const Text('Sucesso! :D'),
                                                content: const Text('Tarefa editada com sucesso. :)'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () => Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(AppRoutes.listTaskScreen, (Route<dynamic> route) => false),
                                                      child: const Text('Ok')),
                                                ]));
                                  } catch (e) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(title: const Text('Erro! :X'), content: const Text('Erro ao editar tarefa. :('), actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop(AppRoutes.listTaskScreen);
                                                  },
                                                  child: const Text('Ok'))
                                            ]));
                                  }
                                },
                                child: const Text('Ok'))
                          ]));
                } else {
                  try {
                    Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(title: const Text('Sucesso! :D'), content: const Text('Tarefa salva com sucesso. :)'), actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.listTaskScreen, (Route<dynamic> route) => false),
                                  child: const Text('Ok')),
                            ]));
                  } catch (e) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            AlertDialog(title: const Text('Erro! :X'), content: const Text('Erro ao salvar taare. :('), actions: [
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ok')),
                            ]));
                  }
                }
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
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: "Data",
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
            const Divider(thickness: 2),
            ElevatedButton(
                onPressed: () {
                  DateTime date = DateTime.now();
                  double latitude = -20.7546;
                  double longitude = -42.8825;
                  weatherProvider.fetchWeather(date, latitude, longitude);
                },
                child: const Text("Adicionar Tarefa")),
            const SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, weatherProvider, _) {
                if (weatherProvider.weather == null) {
                  return const Text('Nenhum dado de clima disponível');
                }
                return Column(
                  children: [
                    Text('Condição: ${weatherProvider.weather!.description}'),
                    Text('Temperatura: ${weatherProvider.weather!.temperature?.round()}°C'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
