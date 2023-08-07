import 'package:todo_list_provider/app/core/databse/sqlite_conector_factory.dart';
import 'package:todo_list_provider/app/models/task_model.dart';
import 'package:todo_list_provider/app/repositories/task/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final SqliteConectorFactory _sqliteConectorFactory;

  TaskRepositoryImpl({required SqliteConectorFactory sqliteConectorFactory})
      : _sqliteConectorFactory = sqliteConectorFactory;

  @override
  Future<void> save(DateTime date, String description) async {
    final conn = await _sqliteConectorFactory.openConection();
    await conn.insert('todo', {
      'id': null,
      'description': description,
      'data_hora': date.toIso8601String(),
      'finalizado': 0,
    });
  }

  @override
  Future<List<TaskModel>> findByPeriod(DateTime start, DateTime end) async {
    final startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    final endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    final conn = await _sqliteConectorFactory.openConection();
    final result = await conn.rawQuery('''
    select *
      from todo
      where data_hora between ? and ? 
      oder by data_hora
      
''', [
      startFilter.toIso8601String(),
      endFilter.toIso8601String(),
    ]);
    return result.map((task) => TaskModel.loadFromDb(task)).toList();
  }
}
