import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'task_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<SetNewTask> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load data from SharedPreferences on startup
  }

  void _loadTasks() {
    setState(() {
      _tasks = StorageService.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 52, 64, 86),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 63, 78, 91),
        title: const Center(
          child: Text(
            "To do list",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length, // Set the actual length
              itemBuilder: (BuildContext context, index) {
                final task = _tasks[index]; // Get the specific task
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(255, 211, 193, 211),
                  ),
                  child: ListTile(
                    title: Text(
                      task.taskName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      task.taskDescription,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              },
            ),
          ),
          // Instruction bar at the bottom
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: double.infinity,
            color: const Color.fromARGB(255, 63, 78, 91),
            child: const Center(
              child: Text(
                "Press the + Button to add new tasks",
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        onPressed: () async {
          // Wait for the user to come back from the input screen
          await Navigator.of(context).pushNamed("/task_input_screen");
          // Refresh the list immediately after they return
          _loadTasks();
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
