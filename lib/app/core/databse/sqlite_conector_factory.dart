// ignore_for_file: prefer_conditional_assignment

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/databse/sqlite_migration_factory.dart';

class SqliteConectorFactory {
  static const _VRSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';

  static SqliteConectorFactory? _inst;
  Database? _db;
  final _lock = Lock();
  SqliteConectorFactory._();

  factory SqliteConectorFactory() {
    _inst ??= SqliteConectorFactory._();
    return _inst!;
  }

  Future<Database> openConection() async {
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _DATABASE_NAME);
    if (_db == null) {
      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await openDatabase(
            databasePathFinal,
            version: _VRSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpGrade,
            onDowngrade: _onDowGrade,
          );
        }
      });
    }
    return _db!;
  }

  void closeconection() {
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreing_key=on');
  }

  Future<void> _onCreate(Database db, int versio) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }

  Future<void> _onUpGrade(Database db, int oldVersio, int versio) async {
    final batch = db.batch();
    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersio);
    for (var migration in migrations) {
      migration.upGrade(batch);
    }
    batch.commit();
  }
}

Future<void> _onDowGrade(Database db, int oldVersio, int versio) async {}




// factory SqliteConectorFactory() {
  //   if(_inst == null) {      velho metodod!
  //     _inst = SqliteConectorFactory._();
  //   }
  //  //   return _inst!;
  // }
  //metodo de conexao

  /* */