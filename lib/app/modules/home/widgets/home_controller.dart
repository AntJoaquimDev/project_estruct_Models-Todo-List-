import 'package:todo_list_provider/app/core/modules/todo_list_modules.dart';

import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';

import '../../../core/notifier/default_change_notifier.dart';

class HomeController extends DefaultChangeNotifier {
  var filterSelected = TaskFilterEnum.today;
}
