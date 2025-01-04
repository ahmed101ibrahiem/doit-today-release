import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit_today/core/base/bloc/notes_cubit/notes_cubit.dart';
import 'package:doit_today/core/resources/my_color.dart';
import 'package:doit_today/view/notes/viewmodel/notes_viewmodel.dart';
import 'package:doit_today/view/notes/widgets/notes_card.dart';
import 'package:doit_today/widgets/custom_text/custom_text.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final NotesViewmodel vm = NotesViewmodel();

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
          title: 'My Notes',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: MyColors.primary,
          ),
        ),
      ),
      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesUpdateState) {
            final notes = state.model ?? [];
            
            if (notes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_alt_outlined,
                      size: 64.r,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16.h),
                    CustomText(
                      title: 'No notes yet',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      title: 'Tap the + button to create one',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.only(top: 8.h, bottom: 80.h),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return NoteCard(
                  note: notes[index],
                  onDelete: () {
                    vm.deleteNote(context, noteId: notes[index].id!);
                  },
                  onTap: () {
                    vm.navigateToAddNotes(context, note: notes[index], isEdit: true);
                  },
                );
              },
            );
          }
          
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => vm.navigateToAddNotes(context),
        icon: const Icon(Icons.add),
        label: const Text('Add Note'),
      ),
    );
  }
}