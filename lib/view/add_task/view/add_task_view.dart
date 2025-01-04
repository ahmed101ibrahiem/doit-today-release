


import 'package:doit_today/core/base/bloc/todo_cubit/todo_cubit.dart';
import 'package:doit_today/core/base/injection/locator.dart';
import 'package:doit_today/core/models/request/todo_model.dart';
import 'package:doit_today/core/services/sql_service/sql_service.dart';
import 'package:doit_today/widgets/custom_button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final todo = TodoModel(
        title: _titleController.text,
        description: _descriptionController.text,
      );
      
      // Use your existing SQL service through the viewmodel
      await locator<SqlService>().insertTodo(todo: todo);
      
      // Reload todos and update state
      if (mounted) {
        final todos = await locator<SqlService>().loadTodos();
        if(context.mounted){
        context.read<TodosCubit>().onUpdateTodosList(todos);
        Navigator.pop(context);
      }}
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20).r,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add New Task',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            TextFormField(
              maxLength: 32,
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a title' : null,
            ),
            16.verticalSpace,
            TextFormField(
              maxLength: 150,
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) =>
                  value?.isEmpty ?? true ? 'Please enter a description' : null,
            ),
            20.verticalSpace,
            CustomButton(title: 'Add Task', onTap: () => _submitForm(context)),
            
          ],
        ),
      ),
    );
  }
}
