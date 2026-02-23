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
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 52, 64, 86),
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.pending_actions)),
              Tab(icon: Icon(Icons.done)),
            ],
          ),
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
                itemCount: _tasks.length,
                itemBuilder: (BuildContext context, index) {
                  final task = _tasks[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      extentRatio: 0.25,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            setState(() {
                              StorageService.deleteFromTaskList(index);
                              _loadTasks();
                            });
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Container(
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
                        trailing: IconButton(
                          icon: const Icon(Icons.done, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              StorageService.isTaskDone(index);
                              _loadTasks();
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onPressed: () async {
            await Navigator.of(context).pushNamed("/task_input_screen");
            _loadTasks();
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
