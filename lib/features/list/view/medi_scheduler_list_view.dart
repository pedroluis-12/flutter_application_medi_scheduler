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
  dispose() {
    _listViewModel.close();
    super.dispose();
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
        onPressed: () => Navigation(context: context, viewModel: _listViewModel).goToForm(null),
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
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
      onTap: () => Navigation(context: context, viewModel: viewModel).goToForm(item),
      child: ListTile(
        leading: const Icon(Icons.medication_outlined, color: Colors.lightBlue),
        title: Text(
          item.medicineName ?? "",
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        subtitle: Text(
          item.time ?? "",
          style: const TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Dialog(viewModel: viewModel, context: context).deleteMedicine(id: item.id!);
          },
        ),
      ),
    ));
  }
}

class Dialog {
  const Dialog({required this.context, required this.viewModel});

  final MediSchedulerListViewModel viewModel;
  final BuildContext context;

  void deleteMedicine({required int id}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Row(children: [
              Icon(
                Icons.delete,
                color: Colors.lightBlue,
              ),
              Text('Remover Medicamento',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.bold))
            ]),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Deseja realmente remover este medicamento?'),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.lightBlue)),
                onPressed: () {
                  viewModel.delete(id!);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Remédio removido com sucesso",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.green,
                  ));
                  viewModel.getList();
                },
                child: const Text('Sim',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Não',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          );
        });
  }
}

class Navigation {
  const Navigation({required this.context, required this.viewModel});

  final MediSchedulerListViewModel viewModel;
  final BuildContext context;

  void goToForm(MediSchedulerModel? medicineModel) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              MediSchedulerFormView(medicineModel: medicineModel)),
    );
    viewModel.getList();
  }
  
}
