// lib/services/storage_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../task_model.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> deleteFromTaskList(int index) async {
    // 1. Get the current list of tasks
    List<SetNewTask> tasks = getAllTasks();

    // 2. Check if index is valid to avoid crashes
    if (index >= 0 && index < tasks.length) {
      tasks.removeAt(index);

      // 3. Encode the updated list back to JSON
      final String jsonString = jsonEncode(
        tasks.map((t) => t.toMap()).toList(),
      );

      // 4. Save using the correct key: 'tasks_list'
      await _prefs.setString('tasks_list', jsonString);
    }
  }

  static Future<void> saveTask(SetNewTask task) async {
    final List<SetNewTask> currentTasks = getAllTasks();
    currentTasks.add(task);

    // Convert list of objects to JSON string
    final String jsonString = jsonEncode(
      currentTasks.map((t) => t.toMap()).toList(),
    );

    await _prefs.setString('tasks_list', jsonString);
  }

  static List<SetNewTask> getAllTasks() {
    final String? jsonString = _prefs.getString('tasks_list');
    if (jsonString == null || jsonString.isEmpty) return [];

    try {
      final List<dynamic> decodedList = jsonDecode(jsonString);
      return decodedList.map((item) => SetNewTask.fromMap(item)).toList();
    } catch (e) {
      log("Error decoding tasks: $e");
      return [];
    }
  }
}
