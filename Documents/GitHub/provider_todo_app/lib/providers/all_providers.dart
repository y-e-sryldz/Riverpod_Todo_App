import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_todo_app/models/todo_model.dart';
import 'package:provider_todo_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoFilter { all, active, completed }

final todoListFilter = StateProvider<TodoFilter>((ref) => TodoFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: Uuid().v4(), description: 'description1'),
    TodoModel(id: Uuid().v4(), description: 'description2'),
    TodoModel(id: Uuid().v4(), description: 'description3')
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final todoList = ref.watch(todoListProvider);
    switch (filter) {
      case TodoFilter.all:
        return todoList;
      case TodoFilter.completed:
        return todoList.where((element) => element.complated).toList();
      case TodoFilter.active:
        return todoList.where((element) => !element.complated).toList();
      default:
        throw UnimplementedError();
    }
  },
);

final unCompletedTodoCaount = Provider<int>(
  (ref) {
    return ref
        .watch(todoListProvider)
        .where((element) => !element.complated)
        .length;
  },
);

final currentTodo = Provider<TodoModel>(
  (ref) {
    throw UnimplementedError();
  },
);
