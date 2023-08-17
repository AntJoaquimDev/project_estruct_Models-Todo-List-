import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/task/task_service.dart';

class TaskCreateController extends DefaultChangeNotifier {
  final TaskService _taskService;
  DateTime? _selectedDate;
  TaskCreateController({required TaskService taskService})
      : _taskService = taskService;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? selectedDate) {
    resetState();
    _selectedDate = selectedDate;
    notifyListeners();
  }

  Future<void> save(String description) async {
    try {
      showLoadingAndRessetState();
      notifyListeners();
      if (_selectedDate != null) {
        await _taskService.save(_selectedDate!, description);
        success();
      } else {
        setError('Data da Task não Selecionada.');
      }
    } catch (e) {
      setError('Erro ao crear Uma Tarefa');
    } finally {
      hideLoanding();
      notifyListeners();
    }
  }
}
