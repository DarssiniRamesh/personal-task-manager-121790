import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/todo_card.dart';
import 'add_todo_page.dart';

/// Main Todo list screen with:
/// - Custom AppBar (height 118, background #9395D3, title "TODO APP", calendar icon)
/// - Scrollable list of todo cards
/// - Bottom filter bar ("All" and "Completed")
/// - Floating action button to add new todo
// PUBLIC_INTERFACE
class TodoPage extends StatelessWidget {
  // PUBLIC_INTERFACE
  const TodoPage({super.key});

  void _onTapEdit(BuildContext context, String id, String currentTitle) async {
    final controller = TextEditingController(text: currentTitle);
    final provider = context.read<TodoProvider>();

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit todo title'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      provider.editTodo(id: id, title: result);
    }
  }

  Future<void> _onTapDelete(BuildContext context, String id) async {
    final provider = context.read<TodoProvider>();
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete this todo?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirm == true) {
      provider.deleteTodo(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TodoProvider>();
    final items = provider.items;
    final showCompletedOnly = provider.showCompletedOnly;

    return Scaffold(
      backgroundColor: AppTheme.colorWhite,
      body: Stack(
        children: [
          // Content list area
          Positioned.fill(
            top: 44 + AppTheme.appBarHeight,
            bottom: AppTheme.bottomNavHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 20),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return TodoCard(
                    item: item,
                    onEdit: () =>
                        _onTapEdit(context, item.id, item.title),
                    onDelete: () => _onTapDelete(context, item.id),
                    onToggleComplete: () =>
                        context.read<TodoProvider>().toggleCompleted(item.id),
                    onTap: () =>
                        context.read<TodoProvider>().toggleCompleted(item.id),
                  );
                },
              ),
            ),
          ),

          // Status bar placeholder (light bg, dark icons area). In Flutter,
          // SafeArea handles this; we model visual spacing with a container.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 44,
            child: Container(color: AppTheme.colorWhite),
          ),

          // Custom AppBar
          Positioned(
            top: 44,
            left: 0,
            right: 0,
            height: AppTheme.appBarHeight,
            child: Container(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 24),
              color: AppTheme.color9395d3,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'TODO APP',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  // Calendar icon to the right
                  const Positioned(
                    right: 10,
                    top: 16,
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Center(
                        child: Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom filter navigation
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: AppTheme.bottomNavHeight,
            child: Container(
              color: AppTheme.colorWhite,
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavItem(
                    label: 'All',
                    icon: Icons.playlist_add_check_outlined,
                    active: !showCompletedOnly,
                    onTap: () => context
                        .read<TodoProvider>()
                        .setFilter(completedOnly: false),
                  ),
                  _NavItem(
                    label: 'Completed',
                    icon: Icons.done_all_outlined,
                    active: showCompletedOnly,
                    onTap: () => context
                        .read<TodoProvider>()
                        .setFilter(completedOnly: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating Add button (70x70), above bottom nav
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 28, right: 24),
        child: SizedBox(
          width: AppTheme.fabSize,
          height: AppTheme.fabSize,
          child: FloatingActionButton(
            tooltip: 'Add New ToDo',
            shape: const CircleBorder(),
            backgroundColor: AppTheme.color9395d3,
            elevation: 6, // approximate shadow
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const AddTodoPage()),
              );
            },
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final activeStyle = const TextStyle(
      fontSize: 10,
      height: 14.45 / 10,
      fontWeight: FontWeight.w600,
      color: AppTheme.color9395d3, // typo_6 color
    );
    final inactiveStyle = const TextStyle(
      fontSize: 10,
      height: 14.45 / 10,
      fontWeight: FontWeight.w400,
      color: AppTheme.color8b8787, // typo_7 color
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 80,
        height: AppTheme.bottomNavHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon,
                size: 28,
                color: active ? AppTheme.color9395d3 : AppTheme.color8b8787),
            const SizedBox(height: 6),
            Text(label, style: active ? activeStyle : inactiveStyle),
          ],
        ),
      ),
    );
  }
}
