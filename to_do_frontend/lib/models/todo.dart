 

/// A domain model representing a single Todo item.
// PUBLIC_INTERFACE
class TodoItem {
  /// Unique identifier for the Todo.
  final String id;

  /// Primary title text.
  final String title;

  /// Secondary detail/description text.
  final String subtitle;

  /// Completion state.
  final bool completed;

  /// Create a new todo item (immutable).
  // PUBLIC_INTERFACE
  const TodoItem({
    required this.id,
    required this.title,
    required this.subtitle,
    this.completed = false,
  });

  /// Returns a copy with selected fields replaced.
  // PUBLIC_INTERFACE
  TodoItem copyWith({
    String? id,
    String? title,
    String? subtitle,
    bool? completed,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      completed: completed ?? this.completed,
    );
  }

  @override
  String toString() {
    return 'TodoItem(id: $id, title: $title, subtitle: $subtitle, completed: $completed)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          subtitle == other.subtitle &&
          completed == other.completed;

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ subtitle.hashCode ^ completed.hashCode;
}
