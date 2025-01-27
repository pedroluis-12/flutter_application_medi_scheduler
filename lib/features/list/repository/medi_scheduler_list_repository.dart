import '../../../commons/model/medi_scheduler_model.dart';
import '../../../commons/service/medi_scheduler_database_helper.dart';
import 'mapper/medi_scheduler_list_repository_mapper.dart';

class MediSchedulerListRepository {
  final _databaseHelper = MediSchedulerDatabaseHelper.instance;
  final _mapper = MediSchedulerListRepositoryMapper();

  Future<List<MediSchedulerModel>> getList() async {
    final db = await _databaseHelper.database;
    final result = await db.query(MediSchedulerDatabaseHelper.tableMedicines,
        orderBy: '${MediSchedulerDatabaseHelper.colId} ASC');

    return _mapper.convertMapToModel(result);
  }

  Future<void> delete(int id) async {
    final db = await _databaseHelper.database;

    await db.delete(MediSchedulerDatabaseHelper.tableMedicines,
        where: "${MediSchedulerDatabaseHelper.colId} = ?", whereArgs: [id]);
  }
}
