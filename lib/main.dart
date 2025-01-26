import 'package:flutter/material.dart';
import 'package:flutter_application_medi_scheduler/features/list/view/medi_scheduler_list_view.dart';
import 'package:flutter_application_medi_scheduler/features/list/viewmodel/medi_scheduler_list_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MediSchedulerListViewModel>(
          create: (_) => MediSchedulerListViewModel()
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Medi Scheduler',
      home: MediSchedulerListView(),
    );
  }
}
