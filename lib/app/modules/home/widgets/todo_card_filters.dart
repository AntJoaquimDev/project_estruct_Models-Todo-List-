import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extension.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';

class TodoCardFilter extends StatelessWidget {
  final String label;
  final TaskFilterEnum taslFilter;
  final TotalTasksModel? totalTasksModel;
  final bool selected;

  const TodoCardFilter({
    super.key,
    required this.label,
    required this.taslFilter,
    this.totalTasksModel,
    required this.selected,
  });

  double _getPercentFinish() {
    final total = totalTasksModel!.totalTask ?? 0.0;
    final totalFinish = totalTasksModel!.totalTaskFinish ?? 0.1;
    if (total == 0) {
      return 0.0;
    }
    final percent = (totalFinish * 100) / total;
    return percent / 100;
  }

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
          color: selected ? context.primaryColor : Colors.white,
          border: Border.all(
            width: 1,
            color: Colors.grey.withOpacity(.8),
          ),
          borderRadius: BorderRadius.circular(26)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${totalTasksModel?.totalTask ?? 0} TASK',
            style: context.titleStyle.copyWith(
                fontSize: 10,
                color: selected ? Colors.white : Colors.grey,
                fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            style: context.titleStyle.copyWith(
              fontSize: 25,
              color: selected ? Colors.white : Colors.grey,
            ),
          ),
          TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0.0,
              end: _getPercentFinish(),
            ),
            duration: const Duration(seconds: 1),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                backgroundColor:
                    selected ? context.primaryColorLight : Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                    selected ? Colors.white : context.primaryColor),
                value: value,
              );
            },
          ),
        ],
      ),
    );
  }
}
