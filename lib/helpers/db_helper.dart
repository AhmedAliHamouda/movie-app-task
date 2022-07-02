import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sql.dart';

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'popular_people.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE actors_data(id INT ,known_for_department TEXT,name TEXT,profile_path TEXT)');
      },
      version: 1,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return await db.query(table);
  }

  static Future<void> insert({required String table, required Map<String, dynamic> data}) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<int> clearData(String table) async {
    final db = await DBHelper.database();
    return await db.delete(table);
  }
}
