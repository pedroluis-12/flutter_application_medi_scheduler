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
  static const String colMedicineName = 'medicineName';
  static const String colTime = 'time';
  static const String colDescription = 'description';


  Future<Database> get database async {
    if (_database != null) {
       _database = await _initDatabase();
    } else {
      _database = await _createDatabase();
    }

    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);

    return await openDatabase(path, version: versionNumber);
  }

  _createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);

    return await openDatabase(path, version: versionNumber, onCreate: _onCreateTable);
  }

  _onCreateTable(Database db, int intVersion) async {
    await db.execute("CREATE TABLE IF NOT EXISTS $tableMedicines ("
        " $colId INTEGER PRIMARY KEY AUTOINCREMENT, "
        " $colMedicineName TEXT NOT NULL, "
        " $colTime TEXT NOT NULL, "
        " $colDescription TEXT"
        ")");
  }
}
