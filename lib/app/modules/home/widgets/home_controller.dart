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

  List<TaskModel> allTasks = [];
  List<TaskModel> filteredTasks = [];
  DateTime? initialDateOfWeek;
  DateTime? selectDay;
  bool showFinishingTasks = false;

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
        totalTask: todayTask.length,
        totalTaskFinish: tomorrowTask.where((task) => task.finish).length);

    tomorrowTotaTasks = TotalTasksModel(
        totalTask: tomorrowTask.length,
        totalTaskFinish: todayTask.where((task) => task.finish).length);

    weekTotaTasks = TotalTasksModel(
        totalTask: weekTask.tasks.length,
        totalTaskFinish: weekTask.tasks.where((task) => task.finish).length);
    notifyListeners();
  }

  Future<void> findTasks({required TaskFilterEnum filter}) async {
    showLoanding();
    filterSelected = filter;
    notifyListeners();
    List<TaskModel> tasks;

    switch (filter) {
      case TaskFilterEnum.today:
        tasks = await _taskService.getToday();
        break;
      case TaskFilterEnum.tomorrow:
        tasks = await _taskService.getTomorrow();
        break;
      case TaskFilterEnum.week:
        final weekModel = await _taskService.getWeek();
        tasks = weekModel.tasks;
        initialDateOfWeek = weekModel.startDate;
        break;
    }
    filteredTasks = tasks;
    allTasks = tasks;

    if (filter == TaskFilterEnum.week) {
      if (selectDay != null) {
        filterByDay(selectDay!);
      } else if (initialDateOfWeek != null) {
        filterByDay(initialDateOfWeek!);
      }
    } else {
      selectDay == null;
    }
    if (!showFinishingTasks) {
      filteredTasks = filteredTasks.where((task) => !task.finish).toList();
    }

    hideLoanding();
    notifyListeners();
  }

  void refreshPage() async {
    await findTasks(filter: filterSelected);
    await loadTotalTasks();
    notifyListeners();
  }

  void filterByDay(DateTime date) {
    selectDay == date;
    filteredTasks = allTasks.where((task) => task.dateTime == date).toList();
    notifyListeners();
  }

  Future<void> isCheckOrUnCheck(TaskModel task) async {
    showLoadingAndRessetState();
    notifyListeners();
    final taskUpdate = task.copyWith(
      finish: !task.finish,
    );
    await _taskService.checkOrCheckTask(taskUpdate);
    hideLoanding();
    refreshPage();
  }

  void showOrHIderFinishingTaskd() {
    showFinishingTasks = !showFinishingTasks;
    notifyListeners();
    refreshPage();
  }
}
