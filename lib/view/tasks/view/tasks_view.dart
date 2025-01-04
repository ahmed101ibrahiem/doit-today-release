import 'package:doit_today/core/base/bloc/todo_cubit/todo_cubit.dart';
import 'package:doit_today/core/resources/my_color.dart';
import 'package:doit_today/core/resources/my_styles.dart';
import 'package:doit_today/view/tasks/viewmodel/tasks_viewmodel.dart';
import 'package:doit_today/view/tasks/widgets/tasks_card.dart';
import 'package:doit_today/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksView extends StatefulWidget {
  const TasksView({super.key});

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final TasksViewmode vm = TasksViewmode();

  @override
  void initState() {
    super.initState();
    vm.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.white,
        elevation: 0,
        centerTitle: true,
        title: CustomText(
          title: 'Tasks',
          style: TextStyle(
              fontSize: 24,
              color: MyColors.primary,
              fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => vm.navigateToAddTask(context),
        heroTag: 'addTaskFAB',
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (context, state) {
          if (state.data == null || state.data!.isEmpty) {
            return Center(
              child: CustomText(
                title: 'No tasks yet. Add some!',
                style: MyStyles.textStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.data!.length,
            itemBuilder: (context, index) {
              final todo = state.data![index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TodoCard(
                  todo: todo,
                  onToggle: () => vm.toggleTodo(context, todo),
                  onDelete: () => vm.deleteTodo(context, todo.id!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
