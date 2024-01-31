import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/task_provider.dart';
import 'package:todolist/screens/task_form.dart';

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _ListTaskState();
}

class _ListTaskState extends State<ListTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas'), titleTextStyle: const TextStyle(fontSize: 17), actions: [
        IconButton(
            onPressed: () {
              //Navigator.of(context).popAndPushNamed(AppRoutes.characterSheetScreen);
            },
            icon: const Icon(Icons.add))
      ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: Provider.of<TaskProvider>(context, listen: false).loadTasks(),
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator())
                  : Consumer<TaskProvider>(
                      builder: (context, tasks, child) => tasks.itemsCount == 0
                          ? child!
                          : ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    child: ListTile(
                                        leading: const CircleAvatar(child: Text('P')),
                                        title: Text(tasks.characterByIndex(index).title),
                                        subtitle: Text(tasks.characterByIndex(index).time),
                                        trailing: IconButton(
                                            onPressed: () => showDialog(
                                                context: context,
                                                builder: (BuildContext contex) => AlertDialog(
                                                        title: const Text('Excluir Tarefa'),
                                                        content: const Text('Deseja mesmo excluir Tarefa?'),
                                                        actions: [
                                                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
                                                          TextButton(
                                                              onPressed: () {
                                                                try {
                                                                  tasks.delete(tasks.characterByIndex(index).id!);
                                                                  Navigator.pop(context);
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) => AlertDialog(
                                                                              title: const Text('Sucesso! :D'),
                                                                              content: const Text('Tarefa deletada com sucesso. :)'),
                                                                              actions: [
                                                                                TextButton(
                                                                                    onPressed: () => Navigator.pop(context), child: const Text('Ok')),
                                                                              ]));
                                                                } catch (e) {
                                                                  showDialog(
                                                                      context: context,
                                                                      builder: (BuildContext context) => AlertDialog(
                                                                              title: const Text('Erro! :X'),
                                                                              content: const Text('Erro ao deletar tarefa. :('),
                                                                              actions: [
                                                                                TextButton(
                                                                                    onPressed: () => Navigator.pop(context), child: const Text('Ok')),
                                                                              ]));
                                                                }
                                                              },
                                                              child: const Text('Ok'))
                                                        ])),
                                            icon: const Icon(Icons.delete_forever_outlined, color: Colors.black)),
                                        onTap: () =>
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const TaskForm())))));
                              },
                              itemCount: tasks.itemsCount,
                            ),
                      child: const Center(child: Text('Lista de tarefas vazia!')))),
        ],
      ),
    );
  }
}
