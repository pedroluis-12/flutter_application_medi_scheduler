import 'package:flutter/material.dart';
import 'package:flutter_application_medi_scheduler/features/list/viewmodel/medi_scheduler_list_viewmodel.dart';
import 'package:provider/provider.dart';

import '../model/medi_scheduler_list_model.dart';

class MediSchedulerListView extends StatelessWidget {
  const MediSchedulerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Medicamentos',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Consumer<MediSchedulerListViewModel>(
          builder: (context, viewmodel, child) {
        if (!viewmodel.fetchingData && viewmodel.mediSchedulerList.isEmpty) {
          Provider.of<MediSchedulerListViewModel>(context, listen: false)
              .getList();
        }
        
        if (viewmodel.fetchingData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<MediSchedulerListModel> mediSchedulerList =
              viewmodel.mediSchedulerList;
          return ListView.builder(
            itemCount: mediSchedulerList.length,
            itemBuilder: (context, index) {
              return ListCard(
                item: mediSchedulerList[index],
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.item});

  final MediSchedulerListModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: GestureDetector(
      onTap: () {
        print('Card tapped');
      },
      child: ListTile(
        leading: const Icon(Icons.medication_liquid, color: Colors.lightBlue),
        title: Text(
          item.title ?? "",
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          item.subTitle ?? "",
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            print('Delete');
          },
        ),
      ),
    ));
  }
}
