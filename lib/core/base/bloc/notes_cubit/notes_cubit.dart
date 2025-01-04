import 'package:doit_today/core/models/request/note.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesInitial());

  void onUpdateUserData(List<NoteModel> model) {
    emit(NotesUpdateState(model: model, changed: !state.changed!));
  }
}
