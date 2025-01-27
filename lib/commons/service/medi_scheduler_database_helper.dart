import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MediSchedulerDatabaseHelper {
  static final MediSchedulerDatabaseHelper instance =
      MediSchedulerDatabaseHelper._internal();
  static Database? _database;

  MediSchedulerDatabaseHelper._internal();

  static const String databaseName = 'medischeduler_database.db';
  static const int versionNumber = 1;

  static const String tableMedicines = 'medicines';

  static const String colId = 'id';
  static const String colTitle = 'title';
  static const String colDescription = 'description';

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();

    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, databaseName);

    var db =
        await openDatabase(path, version: versionNumber, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableMedicines ("
        " $colId INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $colTitle TEXT NOT NULL, "
        " $colDescription TEXT"
        ")");
  }
}
