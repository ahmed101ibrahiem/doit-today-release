import 'package:doit_today/core/base/injection/locator.dart';
import 'package:doit_today/core/base/bloc/notes_cubit/notes_cubit.dart';
import 'package:doit_today/core/models/request/note.model.dart';
import 'package:doit_today/core/services/alert_service/alert_service.dart';
import 'package:doit_today/core/services/navigation_service/navigation_service.dart';
import 'package:doit_today/core/services/sql_service/sql_service.dart';
import 'package:doit_today/view/Profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNotesViewModel {
  final _sqlService = locator<SqlService>();
  final _navService = locator<NavigationService>();
  final _alertService = locator<AlertService>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  // validation

  void validNote(BuildContext context, {bool isEdit = false, int? noteId}) {
    if (titleController.text.isNotEmpty || contentController.text.isNotEmpty) {
      if (isEdit && noteId != null) {
        editNote(context, noteId);
      } else {
        addNotes(context);
      }
    } else {
      _alertService.showAlert(title: 'Please fill note data');
    }
  }

  Future<void> addNotes(BuildContext context) async {
    final note = NoteModel(
      title: titleController.text,
      content: contentController.text,
      createdAt: DateTime.now(),
    );
    await _sqlService.insertNote(note: note);
    final allNotes = await _sqlService.loadNotes();
    if (context.mounted) {
      context.read<NotesCubit>().onUpdateUserData(allNotes);
      context.read<ProfileCubit>().loadProfileStats();

      _navService.pop(context);
    }
  }

  Future<void> editNote(BuildContext context, int noteId) async {
    final note = NoteModel(
      id: noteId,
      title: titleController.text,
      content: contentController.text,
      createdAt: DateTime.now(),
    );
    await _sqlService.updateNote(note);
    final allNotes = await _sqlService.loadNotes();
    if (context.mounted) {
      context.read<NotesCubit>().onUpdateUserData(allNotes);
      context.read<ProfileCubit>().loadProfileStats();

      _navService.pop(context);
    }
  }
}
