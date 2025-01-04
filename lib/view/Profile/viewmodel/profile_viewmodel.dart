
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:doit_today/core/base/injection/locator.dart';
import 'package:doit_today/core/services/sql_service/sql_service.dart';


class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileInitial());
  final _sqlService = locator<SqlService>();

  Future<void> loadProfileStats() async {
    final todos = await _sqlService.loadTodos();
    final notes = await _sqlService.loadNotes();

    final completedTasks = todos.where((todo) => todo.isCompleted).length;
    final pendingTasks = todos.where((todo) => !todo.isCompleted).length;

    emit(ProfileLoaded(
      completedTasks: completedTasks,
      pendingTasks: pendingTasks,
      totalNotes: notes.length,
      totalTasks: todos.length,
    ));
  }
}

// profile_state.dart

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object?> get props => [];
}

class ProfileLoaded extends ProfileState {
  final int completedTasks;
  final int pendingTasks;
  final int totalNotes;
  final int totalTasks;

  const ProfileLoaded({
    required this.completedTasks,
    required this.pendingTasks,
    required this.totalNotes,
    required this.totalTasks,
  });

  @override
  List<Object?> get props => [completedTasks, pendingTasks, totalNotes, totalTasks];
}