import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/todo.dart';

/// Central state for todos and UI filtering.
// PUBLIC_INTERFACE
class TodoProvider extends ChangeNotifier {
  final List<TodoItem> _items = <TodoItem>[
    // Seed with 4 items to visually match Figma list density.
    TodoItem(id: '1', title: 'TODO TITLE', subtitle: 'TODO SUB TITLE'),
    TodoItem(id: '2', title: 'TODO TITLE', subtitle: 'TODO SUB TITLE'),
    TodoItem(id: '3', title: 'TODO TITLE', subtitle: 'TODO SUB TITLE'),
    TodoItem(id: '4', title: 'TODO TITLE', subtitle: 'TODO SUB TITLE'),
  ];

  bool _showCompletedOnly = false;

  /// Return the current filtered items according to filter state.
  // PUBLIC_INTERFACE
  List<TodoItem> get items {
    if (_showCompletedOnly) {
      return _items.where((e) => e.completed).toList(growable: false);
    }
    return List.unmodifiable(_items);
  }

  /// Whether Completed filter is active.
  // PUBLIC_INTERFACE
  bool get showCompletedOnly => _showCompletedOnly;

  /// Switch filter to show all or completed only.
  // PUBLIC_INTERFACE
  void setFilter({required bool completedOnly}) {
    _showCompletedOnly = completedOnly;
    notifyListeners();
  }

  /// Add a new todo item with generated id.
  // PUBLIC_INTERFACE
  void addTodo({required String title, required String subtitle}) {
    final String id = DateTime.now().microsecondsSinceEpoch.toString() +
        Random().nextInt(999).toString().padLeft(3, '0');
    _items.insert(
      0,
      TodoItem(
        id: id,
        title: title.trim().isEmpty ? 'TODO TITLE' : title.trim(),
        subtitle: subtitle.trim().isEmpty ? 'TODO SUB TITLE' : subtitle.trim(),
      ),
    );
    notifyListeners();
  }

  /// Edit an existing item (title/subtitle).
  // PUBLIC_INTERFACE
  void editTodo({
    required String id,
    String? title,
    String? subtitle,
  }) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final current = _items[idx];
    _items[idx] = current.copyWith(
      title: (title ?? current.title),
      subtitle: (subtitle ?? current.subtitle),
    );
    notifyListeners();
  }

  /// Toggle completion state for the given id.
  // PUBLIC_INTERFACE
  void toggleCompleted(String id) {
    final idx = _items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    _items[idx] = _items[idx].copyWith(completed: !_items[idx].completed);
    notifyListeners();
  }

  /// Remove a todo by id.
  // PUBLIC_INTERFACE
  void deleteTodo(String id) {
    _items.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}
