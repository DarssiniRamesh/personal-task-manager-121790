import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../theme/app_theme.dart';

/// A single Todo list row with title, subtitle and action icons,
//  styled to match the Figma card (height 82, rounded 15, shadow).
// PUBLIC_INTERFACE
class TodoCard extends StatelessWidget {
  /// The todo item to render.
  final TodoItem item;

  /// Handler for edit action.
  final VoidCallback onEdit;

  /// Handler for delete action.
  final VoidCallback onDelete;

  /// Handler for toggle complete action.
  final VoidCallback onToggleComplete;

  /// Called when the whole card background is tapped (optional UX).
  final VoidCallback? onTap;

  // PUBLIC_INTERFACE
  const TodoCard({
    super.key,
    required this.item,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleComplete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleMedium!;
    final subtitleStyle = Theme.of(context).textTheme.bodySmall!;
    final completedStyle = subtitleStyle.copyWith(
      color: AppTheme.color8b8787,
      decoration: TextDecoration.lineThrough,
    );
    final titleCompletedStyle = titleStyle.copyWith(
      color: AppTheme.color8b8787,
      decoration: TextDecoration.lineThrough,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppTheme.cardHeight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.colorWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: item.completed ? titleCompletedStyle : titleStyle,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: item.completed ? completedStyle : subtitleStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Actions: edit, delete, check (each 25x25 approx)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  tooltip: 'Edit',
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined, size: 24),
                  splashRadius: 18,
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline, size: 24),
                  splashRadius: 18,
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: item.completed ? 'Mark as Incomplete' : 'Complete',
                  onPressed: onToggleComplete,
                  icon: Icon(
                    item.completed
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    size: 24,
                    color: item.completed
                        ? Colors.green.shade600
                        : Theme.of(context).colorScheme.primary,
                  ),
                  splashRadius: 18,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
