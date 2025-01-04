import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:doit_today/core/models/request/note.model.dart';
import 'package:doit_today/core/resources/my_styles.dart';
import 'package:doit_today/widgets/custom_text/custom_text.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const NoteCard({
    required this.note,
    required this.onDelete,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id.toString()),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Note'),
            content: const Text('Are you sure you want to delete this note?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  onDelete();
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Colors.red.shade100,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: Icon(
          Icons.delete_outline,
          color: Colors.red,
          size: 24.r,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
        elevation: 2,
        color: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          
          borderRadius: MyStyles.borderRadius(radius: 12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: MyStyles.borderRadius(radius: 12),
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        title: note.title,
                        style: TextStyle(
                          fontSize: 15.5.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    24.horizontalSpace,
                    CustomText(
                      title: DateFormat('MMM d, y').format(note.createdAt),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                CustomText(
                  title: note.content,
                  style: TextStyle(
                    fontSize: 11.sp,
                    height: 1.5,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black87,
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}