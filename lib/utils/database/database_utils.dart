import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as db;
import 'package:todolist/models/task.dart';

class DataBaseUtils {
  static Future<db.Database> database() async {
    final dbPath = await db.getDatabasesPath();

    return db.openDatabase(
      path.join(dbPath, 'tasks.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks ('
          'id INTEGER PRIMARY KEY AUTOINCREMENT, '
          'title TEXT, '
          'time TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final dataBase = await DataBaseUtils.database();
    await dataBase.insert(table, data, conflictAlgorithm: db.ConflictAlgorithm.replace);
  }

  static Future<void> delete(String table, int? id) async {
    final dataBase = await DataBaseUtils.database();
    await dataBase.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update(String table, Task data) async {
    final dataBase = await DataBaseUtils.database();
    await dataBase.update(table, data.toMap(), where: 'id = ?', whereArgs: [data.id]);
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final dataBase = await DataBaseUtils.database();
    return dataBase.query(table);
  }
}
