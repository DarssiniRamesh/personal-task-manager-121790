import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'screens/todo_page.dart';
import 'theme/app_theme.dart';

/// Entry point of the application rendering the Todo UI that mirrors the
/// provided Figma/HTML design for TODO PAGE and ADD TODO.
// PUBLIC_INTERFACE
void main() {
  runApp(const MyApp());
}

/// Root widget setting up Provider and themed MaterialApp.
// PUBLIC_INTERFACE
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoProvider>(
      create: (_) => TodoProvider(),
      child: MaterialApp(
        title: 'TODO App',
        theme: AppTheme.theme(),
        debugShowCheckedModeBanner: false,
        home: const TodoPage(),
      ),
    );
  }
}
