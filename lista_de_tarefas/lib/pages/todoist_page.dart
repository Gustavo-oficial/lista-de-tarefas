// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/components/task_item.dart';

import '../models/task.dart';

class TodoIstPage extends StatefulWidget {
  const TodoIstPage({super.key});

  @override
  State<TodoIstPage> createState() => _TodoIstPageState();
}

class _TodoIstPageState extends State<TodoIstPage> {
  List<Task> tasks = List.empty(growable: true);
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: taskController,
                      onFieldSubmitted: (value) {
                        if(value.trim().isNotEmpty){
                          setState(() {
                            Task newTask = Task(title: taskController.text, datetime: DateTime.now());
                            tasks.add(newTask);
                            taskController.clear();
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Tarefa',
                        hintText: 'Adicione sua tarefa aqui',
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green
                          )
                        )
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  MaterialButton(
                    color: Colors.green,
                    height: height * .1,
                    minWidth: 20,
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10)
                      )
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        Task newTask = Task(title: taskController.text, datetime: DateTime.now());
                        tasks.add(newTask);
                        taskController.clear();
                      });
                    }
                  )
                ],
              ),
              SizedBox(height: tasks.isEmpty ? 35 : 10),
              if(tasks.isEmpty)
              const Text(
                'Nenhuma tarefa adicionada...',
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w700
                ),
              ),
              Flexible(
                flex: 2,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for(Task task in tasks)
                    TaskItemList(task: task, onDelete: onDelete)
                  ],
                ),
              ),
              if(tasks.isNotEmpty)
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Você possui 0 tarefas pendentes'
                    ),
                  ),
                  const SizedBox(width: 10),
                  MaterialButton(
                    color: Colors.green,
                    height: height * .1,
                    minWidth: 20,
                    elevation: 1,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(10)
                      )
                    ),
                    onPressed: showConfirmDialog,
                    child: const Text(
                      "Limpar tudo",
                      style: TextStyle(
                        color: Colors.white
                      )
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showConfirmDialog(){
    if(tasks.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.grey,
          behavior: SnackBarBehavior.floating,
          content: Text('Nenhuma tarefa adicionada')
        )
      );
    }else{
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text(
            "Limpar tudo?"
          ),
          content: const Text(
            "Deseja realmente excluir todas as suas tarefas?"
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text(
                "Cancelar",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            TextButton(
              onPressed: onAllDelete, 
              child: const Text(
                "Limpar tudo",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold
                )
              )
            )
          ],
        )
      );
    }
  }

  void onAllDelete(){
    setState(() {
      tasks.clear();
    });

    Navigator.pop(context);
  }

  void onDelete(Task task){
    setState(() {
      tasks.remove(task);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: const Text('Clique em desfazer a ação de exclusão'),
        action: SnackBarAction(label: 'Desfazer', onPressed: () {
          setState(() {
            tasks.add(task);
          });
        }),
      )
    );
  }
}
