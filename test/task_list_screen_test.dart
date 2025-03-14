import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/task_list.dart';
import 'mock_shared_prefs.mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'mock_shared_prefs.mocks.dart'; // Import generated mock
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/task_list.dart';

void main() {
  late MockSharedPreferences mockPrefs;
  // cannot directly use the widget as not in tree so pumpwidget maunually adds in tree
  testWidgets('Adding a task updates the task list',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TaskListScreen()));

    final state =
        tester.state<TaskListScreenState>(find.byType(TaskListScreen));

    state.addTask('Learn Flutter');

    await tester.pump();

    expect(state.tasksGetter.length, 1);
    expect(state.tasksGetter[0].title, 'Learn Flutter');
  });

  testWidgets('Toggling a task updates its completion status',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TaskListScreen()));

    final state =
        tester.state<TaskListScreenState>(find.byType(TaskListScreen));

    state.addTask('Complete Homework');

    await tester.pump();
    expect(state.tasksGetter[0].isCompleted, false);
    state.toggleTask(0);
    await tester.pump();
    expect(state.tasksGetter[0].isCompleted, true);
    state.toggleTask(0); // Toggle again
    await tester.pump();
    expect(state.tasksGetter[0].isCompleted, false);
  });

  setUp(() {
    mockPrefs = MockSharedPreferences();
  });

  testWidgets('Loading tasks from mocked SharedPreferences',
      (WidgetTester tester) async {
    when(mockPrefs.getStringList('tasks'))
        .thenReturn(['{"title": "Mock Task", "isCompleted": false}']);

    await tester.pumpWidget(const MaterialApp(home: TaskListScreen()));

    final state =
        tester.state<TaskListScreenState>(find.byType(TaskListScreen));

    await state.loadTasks();
    await tester.pump();

    expect(state.tasksGetter.length, 1);
    expect(state.tasksGetter[0].title, 'Mock Task');
  });
}
