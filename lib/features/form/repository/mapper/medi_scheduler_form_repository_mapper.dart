import '../../../../commons/model/medi_scheduler_model.dart';

class MediSchedulerFormRepositoryMapper {

   Map<String, dynamic> convertModelToMap(MediSchedulerModel model) {
    return {
      'medicineName': model.medicineName,
      'time': model.time,
      'description': model.description,
    };
  }
}