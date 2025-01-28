import 'package:flutter_application_medi_scheduler/commons/model/medi_scheduler_model.dart';

class MediSchedulerListRepositoryMapper {

  List<MediSchedulerModel> convertMapToModel(List<Map<String, Object?>> response) {
    return response.map((json) => _mapToModel(json)).toList();
  }

  MediSchedulerModel _mapToModel(dynamic item) => MediSchedulerModel(
      item['medicineName'],
      item['time'],
      item['description'],
      id: item['id'],
    );
}
