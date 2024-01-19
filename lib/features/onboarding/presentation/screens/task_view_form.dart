import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
class TaskViewFormDialog extends StatefulWidget {
  const TaskViewFormDialog({super.key});

  @override
  State<TaskViewFormDialog> createState() => _TaskViewFormDialogState();
}

class _TaskViewFormDialogState extends State<TaskViewFormDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(child:  Text('jhd')
      // Container(constraints: BoxConstraints(maxHeight: 75.h, maxWidth: 65.w),child: ,)
   );
  }
}