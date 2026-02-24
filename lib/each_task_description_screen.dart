import 'package:flutter/material.dart';
import '/task_model.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)!.settings.arguments as SetNewTask;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 78, 91),
        title:  Text("To Do: ${task.taskName}", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(task.taskDescription, style: TextStyle(color: Colors.white, fontSize: 20,fontStyle: FontStyle.italic),),
      ),
        backgroundColor: const Color.fromARGB(255, 52, 64, 86),
    );
  }
}