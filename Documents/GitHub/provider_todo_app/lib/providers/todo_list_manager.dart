import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_todo_app/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoListManager extends StateNotifier<List<TodoModel>> {
  TodoListManager([List<TodoModel>? initialTodos]) : super(initialTodos ?? []);

  void addTodo(String description) {
    var eklenecekTodu = TodoModel(
      id: Uuid().v4(),
      description: description,
    );
    state = [...state, eklenecekTodu];
  }

  void toogle(String id) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: id,
            description: todo.description,
            complated: !todo.complated,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String newDescription}) {
    state = [
      for (var todo in state)
        if (todo.id == id)
          TodoModel(
            id: id,
            description: newDescription,
            complated: todo.complated,
          )
        else
          todo,
    ];
  }

  void remove(TodoModel silinecekTodo) {
    state = state.where((element) => element.id != silinecekTodo.id).toList();
  }

  int onCompletedTodoCount() {
    return state.where((element) => !element.complated).length;
  }
}
