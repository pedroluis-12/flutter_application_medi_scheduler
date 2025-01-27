import '../../../../commons/model/medi_scheduler_model.dart';

class MediSchedulerFormRepositoryMapper {

   Map<String, dynamic> convertModelToMap(MediSchedulerModel model) {
    return {
      'title': model.title,
      'description': model.description,
    };
  }
}