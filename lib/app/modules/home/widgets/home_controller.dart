import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';

import '../../../core/notifier/default_change_notifier.dart';

class HomeController extends DefaultChangeNotifier {
  final TaskService _taskService;

  TotalTasksModel? todayTotaTasks;
  TotalTasksModel? tomorrowTotaTasks;
  TotalTasksModel? weekTotaTasks;

  HomeController({required TaskService TaskService})
      : _taskService = TaskService;
  var filterSelected = TaskFilterEnum.today;

  Future<void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _taskService.getToday(),
      _taskService.getTomorrow(),
      _taskService.getWeek(),
    ]);

    final todayTask = allTasks[0] as List<TaskModel>;
    final tomorrowTask = allTasks[1] as List<TaskModel>;
    final weekTask = allTasks[2] as WeekTaskModel;

    todayTotaTasks = TotalTasksModel(
        totalTask: tomorrowTask.length,
        totalTaskFinish: tomorrowTask.where((task) => task.finish).length);

    tomorrowTotaTasks = TotalTasksModel(
        totalTask: todayTask.length,
        totalTaskFinish: todayTask.where((task) => task.finish).length);

    weekTotaTasks = TotalTasksModel(
        totalTask: weekTask.tasks.length,
        totalTaskFinish: weekTask.tasks.where((task) => task.finish).length);
    notifyListeners();
  }
}
