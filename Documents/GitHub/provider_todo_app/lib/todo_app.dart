import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_todo_app/models/todo_model.dart';
import 'package:provider_todo_app/providers/all_providers.dart';
import 'package:provider_todo_app/widgets/title_widget.dart';
import 'package:provider_todo_app/widgets/todo_list_item_widget.dart';
import 'package:provider_todo_app/widgets/toolbar_widget.dart';
import 'package:uuid/uuid.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();
  final List<TodoModel> allTodos = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: InputDecoration(
              labelText: 'Bugün Neler yapılacak ?',
            ),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
              newTodoController.clear();
            },
          ),
          SizedBox(height: 20),
          ToolbarWidget(),
          _allTodos.isEmpty
              ? Center(
                  child: Text('Bugün yapılacak bir şey yok'),
                )
              : SizedBox(),
          for (var todo in _allTodos)
            Dismissible(
              key: ValueKey(todo.id),
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(todo);
              },
              child: ProviderScope(
                overrides: [
                  currentTodo.overrideWithValue(todo),
                ],
                child: TodoListItemWidget(),
              ),
            ),
        ],
      ),
    );
  }
}
