import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_controller.dart';

class Task extends StatelessWidget {
  final TaskModel taskModel;
  final dateFormat = DateFormat('dd/MM/y');
  Task({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: taskModel.finish
              ? Color.fromARGB(255, 112, 228, 212)
              : const Color.fromARGB(255, 243, 212, 212),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(181, 158, 158, 158)),
          ]),
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: IntrinsicHeight(
        child: ListTile(
          contentPadding: const EdgeInsets.all(8),
          leading: Checkbox(
            value: taskModel.finish,
            onChanged: (value) =>
                context.read<HomeController>().isCheckOrUnCheck(taskModel),
          ),
          title: Text(
            taskModel.description,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration:
                    taskModel.finish ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            dateFormat.format(taskModel.dateTime),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration:
                    taskModel.finish ? TextDecoration.lineThrough : null),
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
