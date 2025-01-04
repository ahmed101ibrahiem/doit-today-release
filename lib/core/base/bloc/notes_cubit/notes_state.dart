part of 'notes_cubit.dart';

abstract class NotesState extends Equatable {
  const NotesState({this.model, this.changed});
  final List<NoteModel>? model;
  final bool? changed;
}

class NotesInitial extends NotesState {
  const NotesInitial() : super(model: null, changed: false);
  @override
  List<Object> get props => [model!, changed!];
}

class NotesUpdateState extends NotesState {
  const NotesUpdateState({super.model, super.changed});
  @override
  List<Object> get props => [model!, changed!];
}
