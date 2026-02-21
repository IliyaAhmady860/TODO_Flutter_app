import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'task_model.dart';

class TaskInput extends StatefulWidget {
  const TaskInput({super.key});

  @override
  State<TaskInput> createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  @override
  void dispose() {
    nameFieldController.dispose();
    descriptionFieldController.dispose();
    super.dispose();
  }

  final nameFieldController = TextEditingController();
  final descriptionFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "To do list",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey, // 1. Assign the key here
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                // 2. Changed to TextFormField
                controller: nameFieldController,
                validator: (value) => (value == null || value.isEmpty)
                    ? "Name is required"
                    : null,
                maxLength: 20,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  label: Text("Task Name"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                // 2. Changed to TextFormField
                controller: descriptionFieldController,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  label: Text("Task Description"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            SetNewTask newTask = SetNewTask(
              taskName: nameFieldController.text,
              taskDescription: descriptionFieldController.text,
            );
            await StorageService.saveTask(newTask);
            if (context.mounted) Navigator.pop(context);
          }
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
