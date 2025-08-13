import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_frontend/main.dart';

void main() {
  testWidgets('TodoPage renders title and FAB', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Allow initial frames
    await tester.pumpAndSettle();

    // Custom app bar title
    expect(find.text('TODO APP'), findsOneWidget);
    // FAB exists (add button)
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('Navigate to AddTodoPage and back', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Tap FAB to go to AddTodo
    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    // "Add Task" title should be visible
    expect(find.text('Add Task'), findsOneWidget);

    // Go back
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Back on TodoPage
    expect(find.text('TODO APP'), findsOneWidget);
  });
}
