import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_todo_app/models/todo_model.dart';
import 'package:provider_todo_app/providers/all_providers.dart';

class TodoListItemWidget extends ConsumerStatefulWidget {
  const TodoListItemWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TodoListItemWidgetState();
}

class _TodoListItemWidgetState extends ConsumerState<TodoListItemWidget> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentTodoItem = ref.watch(currentTodo);
    return Focus(
      onFocusChange: (isFocused) {
        if (!isFocused) {
          setState(() {
            _hasFocus = false;
          });
          ref.read(todoListProvider.notifier).edit(
                id: currentTodoItem.id,
                newDescription: _textEditingController.text,
              );
        }
      },
      child: ListTile(
        onTap: () {
          setState(() {
            _hasFocus = true;
            _focusNode.requestFocus();
            _textEditingController.text = currentTodoItem.description;
          });
        },
        leading: Checkbox(
          value: currentTodoItem.complated,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toogle(currentTodoItem.id);
          },
        ),
        title: _hasFocus
            ? TextField(
                controller: _textEditingController,
                focusNode: _focusNode,
              )
            : Text(currentTodoItem.description),
      ),
    );
  }
}
