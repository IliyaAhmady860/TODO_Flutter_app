import 'package:flutter/material.dart';
import 'package:to_do_list/each_task_description_screen.dart';
import 'main_screen.dart';
import 'task_input_screen.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/task_input_screen': (context) => const TaskInput(),
        '/each_task_description_screen': (context) => const TaskScreen(),
      },
    );
  }
}
