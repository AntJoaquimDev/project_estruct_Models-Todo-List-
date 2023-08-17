import 'package:sqflite_common/sqlite_api.dart';
import 'package:todo_list_provider/app/core/databse/migrations/migration.dart';

class MigrtionV1 implements Migration {
  @override
  void create(Batch batch) {
    String sql = '''create table todo(
    id Integer primary key autoincrement,
    descricao varchar(400) not null,
    data_hora datetime, 
    finalizado integer
    ) ''';
    batch.execute(sql);
  }

  @override
  void upGrade(Batch batch) {
    // TODO: implement upDate
  }
}
