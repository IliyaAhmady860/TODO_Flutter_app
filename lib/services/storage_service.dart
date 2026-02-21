// lib/services/storage_service.dart
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../task_model.dart'; // <--- Check this path!

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
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
