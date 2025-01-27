import 'package:flutter/foundation.dart';

import '../../../commons/model/medi_scheduler_model.dart';
import '../repository/medi_scheduler_form_repository.dart';

class MediSchedulerFormViewmodel extends ChangeNotifier {
  final MediSchedulerFormRepository _mediSchedulerFormRepository =
      MediSchedulerFormRepository();

  Future<void> saveForm(String title, String description) async {
    MediSchedulerModel mediSchedulerForm =
        MediSchedulerModel(title, description);

    try {
      await _mediSchedulerFormRepository
          .saveMediSchedulerForm(mediSchedulerForm);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateForm(int id, String title, String description) async {
    MediSchedulerModel mediSchedulerForm =
        MediSchedulerModel(title, description, id: id);
    try {
      await _mediSchedulerFormRepository
          .updateMediSchedulerForm(mediSchedulerForm);
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
