import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;

  const TodoCardFilter({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        maxWidth: 150,
      ),
      margin: const EdgeInsets.only(
        right: 10,
      ),
      decoration: BoxDecoration(
          color: context.primaryColor,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(26)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '10 TASK',
            style: context.titleStyle.copyWith(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style:
                context.titleStyle.copyWith(fontSize: 20, color: Colors.white),
          ),
          LinearProgressIndicator(
            backgroundColor: context.primaryColorLight,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            value: 0.4,
          ),
        ],
      ),
    );
  }
}
