import 'package:doit_today/core/models/request/todo_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';

class TodosCubit extends Cubit<TodosState> {
  TodosCubit() : super(TodosInitial());

  void onUpdateTodosList(List<TodoModel> data) {
    final List<TodoModel> reversedList = List.from(data);
    emit(TodosUpdate(data: reversedList, changed: false));
  }
}
