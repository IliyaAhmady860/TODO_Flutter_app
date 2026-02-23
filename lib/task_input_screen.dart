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
        backgroundColor: const Color.fromARGB(255, 63, 78, 91),
        title: const Text(
          "To do list",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameFieldController,
                style: const TextStyle(color: Colors.white),
                validator: (value) => (value == null || value.isEmpty)
                    ? "Name is required"
                    : null,
                maxLength: 20,

                decoration: InputDecoration(
                  counterStyle: const TextStyle(color: Colors.white),

                  filled: true,
                  fillColor: const Color.fromARGB(255, 63, 78, 91),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  labelText: "Task Name",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 1,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.redAccent,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: descriptionFieldController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 63, 78, 91),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  labelText: "Task Description",
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.blue,
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
      backgroundColor: const Color.fromARGB(255, 52, 64, 86),
    );
  }
}
