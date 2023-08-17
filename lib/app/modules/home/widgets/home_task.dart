import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/modules/home/widgets/task.dart';

class HomeTask extends StatelessWidget {
  const HomeTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          'Task\'s de Hoje',
          style: context.titleStyle,
        ),
        Column(
          children: [
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
            Task(),
          ],
        )
      ],
    ));
  }
}
