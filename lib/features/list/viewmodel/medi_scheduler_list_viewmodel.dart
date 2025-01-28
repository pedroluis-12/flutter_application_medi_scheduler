import 'package:flutter/widgets.dart';

import '../repository/medi_scheduler_list_repository.dart';
import '../../../commons/model/medi_scheduler_model.dart';

class MediSchedulerListViewModel extends ChangeNotifier {
  final MediSchedulerListRepository _mediSchedulerListRepository =
      MediSchedulerListRepository();

  bool fetchingData = false;

  List<MediSchedulerModel> _mediSchedulerList = [];
  List<MediSchedulerModel> get mediSchedulerList => _mediSchedulerList;

  Future<void> getList() async {
    fetchingData = true;
    try {
      _mediSchedulerList = await _mediSchedulerListRepository.getList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
    fetchingData = false;
  }

  Future<void> delete(int id) async {
    try {
      await _mediSchedulerListRepository.delete(id);
      _mediSchedulerList.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> close() async {
    await _mediSchedulerListRepository.close();
  } 
}
