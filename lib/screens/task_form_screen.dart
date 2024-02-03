import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/task.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/provider/weather_provider.dart';
import 'package:todolist/utils/routes/app_routes.dart';
import 'package:todolist/widgets/weather_icon.dart';

class TaskFormScreen extends StatefulWidget {
  const TaskFormScreen({super.key, this.task});

  final Task? task;

  @override
  State<TaskFormScreen> createState() => _TaskFormScreen();
}

class _TaskFormScreen extends State<TaskFormScreen> {
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
      resizeToAvoidBottomInset: false,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Tarefa",
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
                  labelText: "Hora",
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(thickness: 2),
              const SizedBox(height: 15),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Condição: ${weatherProvider.weather?.description}', style: const TextStyle(fontSize: 18)),
                      Text('Temperatura: ${weatherProvider.weather?.temperature?.round()}°C', style: const TextStyle(fontSize: 18)),
                      WeatherIcon(description: weatherProvider.weather?.description, sizeIcon: 200),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
