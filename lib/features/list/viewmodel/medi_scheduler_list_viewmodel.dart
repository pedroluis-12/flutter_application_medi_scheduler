import 'package:flutter/widgets.dart';
import '../repository/medi_scheduler_list_repository.dart';
import '../model/medi_scheduler_list_model.dart';

class MediSchedulerListViewModel extends ChangeNotifier {
  final MediSchedulerListRepository _mediSchedulerListRepository = MediSchedulerListRepository();

  bool fetchingData = false;
  
  List<MediSchedulerListModel> _mediSchedulerList = [];
  List<MediSchedulerListModel> get mediSchedulerList => _mediSchedulerList;

  Future<void> getList() async {
    fetchingData = true;
    _mediSchedulerList = await _mediSchedulerListRepository.getList();
    fetchingData = false;
    notifyListeners();
  }
} 