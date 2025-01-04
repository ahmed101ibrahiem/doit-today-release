import 'package:doit_today/core/models/request/note.model.dart';
import 'package:doit_today/core/resources/my_styles.dart';
import 'package:doit_today/view/add_notes/viewmodel/add.notes_viewmodel.dart';
import 'package:doit_today/widgets/custom_button/custom_button.dart';
import 'package:doit_today/widgets/custom_text/custom_text.dart';
import 'package:doit_today/widgets/custom_text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNotesView extends StatefulWidget {
  const AddNotesView({
    super.key,
    this.note,
    this.isEdit = false,
  });
  final bool isEdit;
  final NoteModel? note;
  @override
  State<AddNotesView> createState() => _AddNotesViewState();
}

class _AddNotesViewState extends State<AddNotesView> {
  final vm = AddNotesViewModel();

  @override
  void initState() {
    vm.titleController.text = widget.isEdit ? widget.note!.title : '';
    vm.contentController.text = widget.isEdit ? widget.note!.content : '';
    super.initState();
  }

  @override
  void dispose() {
    vm.titleController.dispose();
    vm.contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16.h,
        children: [
          CustomText(
            title: widget.isEdit ? 'Edit Note' : 'Add Note',
            style: MyStyles.textStyle(fontSize: 18, color: Colors.black),
          ),
          4.verticalSpace,
          CustomTextField(
            controller: vm.titleController,
            title: 'Title',
            isShowBorder: true,
            maxLength: 32,
          ),
          CustomTextField(
            title: 'Content',
            controller: vm.contentController,
            isShowBorder: true,
            maxLines: 5,
          ),
          8.verticalSpace,
          CustomButton(
            onTap: () => vm.validNote(
              context,
              isEdit: widget.isEdit,
              noteId: widget.isEdit ? widget.note?.id : null,
            ),
            title: 'Submit',
            color: Colors.redAccent,
          )
        ],
      ),
    );
  }
}
