import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../list/viewmodel/medi_scheduler_list_viewmodel.dart';
import '../../form/view/medi_scheduler_form_view.dart';
import '../../../commons/model/medi_scheduler_model.dart';

class MediSchedulerListView extends StatefulWidget {
  const MediSchedulerListView({super.key});

  @override
  MediSchedulerListViewState createState() => MediSchedulerListViewState();
}

class MediSchedulerListViewState extends State<MediSchedulerListView> {
  late final MediSchedulerListViewModel _listViewModel;

  void _initViewModel() {
    _listViewModel =
        Provider.of<MediSchedulerListViewModel>(context, listen: false);
  }

  @override
  void initState() {
    _initViewModel();
    _listViewModel.getList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciamento de Medicamentos',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightBlue,
      ),
      body: Consumer<MediSchedulerListViewModel>(
          builder: (context, viewModel, child) {
        if (viewModel.fetchingData) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.lightBlue,
          ));
        } else if (!viewModel.fetchingData &&
            viewModel.mediSchedulerList.isEmpty) {
          return const Center(
            child: Text('Nenhum medicamento cadastrado',
                style: TextStyle(color: Colors.black, fontSize: 16)),
          );
        } else {
          List<MediSchedulerModel> mediSchedulerList =
              viewModel.mediSchedulerList;
          return ListView.builder(
            itemCount: mediSchedulerList.length,
            itemBuilder: (context, index) {
              return ListCard(
                item: mediSchedulerList[index],
                viewModel: viewModel,
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goToForm(),
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  _goToForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MediSchedulerFormView()),
    );
    _listViewModel.getList();
  }
}

class ListCard extends StatelessWidget {
  const ListCard({super.key, required this.item, required this.viewModel});

  final MediSchedulerModel item;
  final MediSchedulerListViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: GestureDetector(
      onTap: () {
        if (kDebugMode) {
          print('Card tapped');
        }
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
          item.description ?? "",
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            viewModel.delete(item.id!);
            viewModel.getList();
          },
        ),
      ),
    ));
  }
}
