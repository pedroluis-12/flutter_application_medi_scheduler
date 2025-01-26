import '../model/medi_scheduler_list_model.dart';

class MediSchedulerListRepository {

  Future<List<MediSchedulerListModel>> getList() async {
    final List<MediSchedulerListModel> mediSchedulerList = await <MediSchedulerListModel>[
      MediSchedulerListModel(title: 'Medicine 1', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 2', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 3', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 4', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 5', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 6', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 7', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 8', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 9', subTitle: 'Time: 8:00 AM'),
      MediSchedulerListModel(title: 'Medicine 10', subTitle: 'Time: 8:00 AM'),
    ];

    return mediSchedulerList;
  }
}