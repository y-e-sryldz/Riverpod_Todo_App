import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_todo_app/providers/all_providers.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({super.key});
  var _currentFilter = TodoFilter.all;

  Color changeTextColor(TodoFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final finishedTodoCount = ref.watch(unCompletedTodoCaount);
    _currentFilter = ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            finishedTodoCount == 0
                ? 'Tüm Görevler OK'
                : '${finishedTodoCount} Görev Tamamlanmadı',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: changeTextColor(TodoFilter.all),
            ),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoFilter.all;
            },
            child: Text('All'),
          ),
        ),
        Tooltip(
          message: 'Only Uncoplated  Todos',
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: changeTextColor(TodoFilter.active),
            ),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoFilter.active;
            },
            child: Text('Active'),
          ),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: changeTextColor(TodoFilter.completed),
            ),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoFilter.completed;
            },
            child: Text('Completed'),
          ),
        ),
      ],
    );
  }
}
