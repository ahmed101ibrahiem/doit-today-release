import 'package:doit_today/core/base/bloc/todo_cubit/todo_cubit.dart';
import 'package:doit_today/core/base/injection/locator.dart';
import 'package:doit_today/core/models/request/todo_model.dart';
import 'package:doit_today/core/services/navigation_service/navigation_service.dart';
import 'package:doit_today/core/services/sql_service/sql_service.dart';
import 'package:doit_today/view/Profile/viewmodel/profile_viewmodel.dart';
import 'package:doit_today/view/add_task/view/add_task_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class TasksViewmode {
  final _sqlService = locator<SqlService>();
  final _navService = locator<NavigationService>();

  Future<void> init(BuildContext context) async {
    await loadTodos(context);
  }

  Future<void> loadTodos(BuildContext context) async {
    final allTasks = await _sqlService.loadTodos();
    if (context.mounted) {
      context.read<TodosCubit>().onUpdateTodosList(allTasks);
          context.read<ProfileCubit>().loadProfileStats();

    }
  }

  Future<void> toggleTodo(BuildContext context, TodoModel todo) async {
    final updatedTodo = TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: !todo.isCompleted,
    );

    await _sqlService.updateTodo(updatedTodo);
    if (context.mounted) {
      await loadTodos(context);
      
    }
  }

  Future<void> deleteTodo(BuildContext context, int id) async {
    await _sqlService.deleteTodo(id);
    if (context.mounted) {
      await loadTodos(context);
    }
  }

  void navigateToAddTask(BuildContext context) {
    _navService.pushWithBottomSheet(
      context,
      haveDynamicSize: true,
      path: const AddTaskView(),
    );
  }
}