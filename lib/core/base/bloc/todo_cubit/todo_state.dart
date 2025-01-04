part of 'todo_cubit.dart';


abstract class TodosState extends Equatable {
  const TodosState({this.data, this.changed});

  final List<TodoModel>? data;
  final bool? changed;
}

class TodosInitial extends TodosState {
  TodosInitial() : super(data: [], changed: false);

  @override
  List<Object> get props => [data!, changed!];
}

class TodosUpdate extends TodosState {
  const TodosUpdate({super.data, super.changed});

  @override
  List<Object> get props => [data!, changed!];
}
