import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'task_input_screen.dart';
import 'services/storage_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init(); // Initialize the service
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove 'home: const MainScreen()'
      // Use initialRoute instead to avoid conflicts with the routes table
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/task_input_screen': (context) => const TaskInput(),
      },
    );
  }
}
