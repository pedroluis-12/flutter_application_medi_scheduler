import 'package:sqflite/sqflite.dart';

import '../../../commons/model/medi_scheduler_model.dart';
import '../../../commons/service/medi_scheduler_database_helper.dart';
import 'mapper/medi_scheduler_form_repository_mapper.dart';

class MediSchedulerFormRepository {
  final _databaseHelper = MediSchedulerDatabaseHelper.instance;
  final _mapper = MediSchedulerFormRepositoryMapper();

  Future<bool> saveMediSchedulerForm(MediSchedulerModel model) async {
    final db = await _databaseHelper.database;

    await db.insert(MediSchedulerDatabaseHelper.tableMedicines,
        _mapper.convertModelToMap(model),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return true;
  }

  Future<void> updateMediSchedulerForm(MediSchedulerModel model) async {
    final db = await _databaseHelper.database;

    await db.update(MediSchedulerDatabaseHelper.tableMedicines,
        _mapper.convertModelToMap(model),
        where: '${MediSchedulerDatabaseHelper.colId} = ?',
        whereArgs: [model.id]);
  }
}
