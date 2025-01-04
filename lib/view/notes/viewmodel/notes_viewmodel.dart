import 'package:doit_today/core/base/injection/locator.dart';
import 'package:doit_today/core/base/bloc/notes_cubit/notes_cubit.dart';
import 'package:doit_today/core/models/request/note.model.dart';
import 'package:doit_today/core/services/navigation_service/navigation_service.dart';
import 'package:doit_today/core/services/sql_service/sql_service.dart';
import 'package:doit_today/view/add_notes/view/add_notes_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesViewmodel {
  init(context) {
    loadNotes(context);
  }

  final _sqlService = locator<SqlService>();
  final _navService = locator<NavigationService>();

  void navigateToAddNotes(BuildContext context, {bool? isEdit , NoteModel? note}) {
    _navService.pushWithBottomSheet(
      context,
      haveDynamicSize: true,

     path:  AddNotesView(
        isEdit: isEdit ?? false,
        note: note,
     ),);
  }



  void loadNotes(context) async {
    final allNotes = await _sqlService.loadNotes();
    BlocProvider.of<NotesCubit>(context).onUpdateUserData(allNotes);
  }

  Future<void> deleteNote(BuildContext context, {required int noteId}) async {
    await _sqlService.deleteNote(noteId);
    final allNotes = await _sqlService.loadNotes();
    if (context.mounted) {
      context.read<NotesCubit>().onUpdateUserData(allNotes);
    }
  }
}
