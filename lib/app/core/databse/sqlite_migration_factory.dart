import 'package:todo_list_provider/app/core/databse/migrations/migration.dart';
import 'package:todo_list_provider/app/core/databse/migrations/migrtion_v1.dart';
import 'package:todo_list_provider/app/core/databse/migrations/migrtion_v2.dart';
import 'package:todo_list_provider/app/core/databse/migrations/migrtion_v3.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrtionV1(),
        MigrtionV2(),
        MigrtionV3(),
      ];
  List<Migration> getUpgradeMigration(int verson) {
    final migration = <Migration>[];
    if (verson == 1) {
      migration.add(MigrtionV2());
      migration.add(MigrtionV3());
    }
    if (verson == 2) {
      migration.add(MigrtionV3());
    }
    return migration;
  }
}
