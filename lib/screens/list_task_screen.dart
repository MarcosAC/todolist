import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/provider/weather_provider.dart';
import 'package:todolist/screens/task_form_screen.dart';
import 'package:todolist/utils/routes/app_routes.dart';
import 'package:todolist/widgets/weather_icon.dart';

class ListTaskScreen extends StatefulWidget {
  const ListTaskScreen({super.key});

  @override
  State<ListTaskScreen> createState() => _ListTaskScreen();
}

class _ListTaskScreen extends State<ListTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Lista de Tarefas'), titleTextStyle: const TextStyle(fontSize: 17), actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).popAndPushNamed(AppRoutes.taskFormScreen);
              },
              icon: const Icon(Icons.add))
        ]),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: FutureBuilder(
                  future: Provider.of<TaskProvider>(context, listen: false).loadTasks(),
                  builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                      ? const Center(child: CircularProgressIndicator())
                      : Consumer<TaskProvider>(
                          builder: (context, tasks, child) => tasks.itemsCount == 0
                              ? child!
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Consumer<WeatherProvider>(builder: (context, weatherProvider, _) {
                                      DateTime date = DateTime.now();
                                      double latitude = -20.7546;
                                      double longitude = -42.8825;
                                      weatherProvider.fetchWeather(date, latitude, longitude);
                                      return Card(
                                          child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.transparent,
                                                child: WeatherIcon(description: weatherProvider.weather?.description),
                                              ),
                                              title: Text(tasks.taskByIndex(index).title),
                                              subtitle: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(tasks.taskByIndex(index).date),
                                                  Text(tasks.taskByIndex(index).time),
                                                  Text('Condição: ${weatherProvider.weather?.description}'),
                                                ],
                                              ),
                                              trailing: IconButton(
                                                  onPressed: () => dialog(context, tasks, index),
                                                  icon: const Icon(Icons.delete_forever_outlined, color: Colors.black)),
                                              onTap: () => Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: ((context) => TaskFormScreen(task: tasks.taskByIndex(index))),
                                                  ))));
                                    });
                                  },
                                  itemCount: tasks.itemsCount,
                                ),
                          child: const Center(child: Text('Lista de tarefas vazia!')))))
        ]));
  }

  dialog(BuildContext context, TaskProvider tasks, int index) {
    return showDialog(
        context: context,
        builder: (BuildContext contex) =>
            AlertDialog(title: const Text('Excluir Tarefa'), content: const Text('Deseja mesmo excluir Tarefa?'), actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    try {
                      tasks.delete(tasks.taskByIndex(index).id!);
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(title: const Text('Sucesso! :D'), content: const Text('Tarefa deletada com sucesso. :)'), actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ok')),
                              ]));
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertDialog(title: const Text('Erro! :X'), content: const Text('Erro ao deletar tarefa. :('), actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('Ok')),
                              ]));
                    }
                  },
                  child: const Text('Ok'))
            ]));
  }
}
