import 'package:flutter/material.dart';
import 'services/storage_service.dart';
import 'task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
    _loadTasks();
  }

  void _loadTasks() {
    setState(() {
      _tasks = StorageService.getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pendingTasks = _tasks.where((task) => !task.isDone).toList();
    final completedTasks = _tasks.where((task) => task.isDone).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 52, 64, 86),
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.white60,
            tabs: [
              Tab(icon: Icon(Icons.pending_actions), text: "Pending"),
              Tab(icon: Icon(Icons.done_all), text: "Done"),
            ],
          ),
          backgroundColor: const Color.fromARGB(255, 63, 78, 91),
          title: const Text("To Do List"),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            _buildTaskList(pendingTasks),
            _buildTaskList(completedTasks),
          ],
        ),
        floatingActionButton: FloatingActionButton.small(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          backgroundColor: Colors.blue,
          onPressed: () async {
            await Navigator.of(context).pushNamed("/task_input_screen");
            _loadTasks();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildTaskList(List<SetNewTask> tasks) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text("No tasks here!", style: TextStyle(color: Colors.white70)),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Slidable(
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  setState(() {
                    int masterIndex = _tasks.indexOf(task);
                    StorageService.deleteFromTaskList(masterIndex);
                    _loadTasks();
                  });
                },
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: const Color.fromARGB(255, 211, 193, 211),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                task.taskName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(task.taskDescription, maxLines: 1),
              trailing: IconButton(
                icon: Icon(
                  task.isDone ? null : Icons.check_circle,
                  color: task.isDone ? null : Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    int masterIndex = _tasks.indexOf(task);
                    StorageService.isTaskDone(masterIndex);
                    _loadTasks();
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
