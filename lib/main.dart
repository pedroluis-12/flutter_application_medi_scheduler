import 'package:flutter/material.dart';
import 'package:flutter_application_medi_scheduler/features/form/viewmodel/medi_scheduler_form_viewmodel.dart';
import 'package:provider/provider.dart';

import 'features/list/view/medi_scheduler_list_view.dart';
import 'features/list/viewmodel/medi_scheduler_list_viewmodel.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<MediSchedulerListViewModel>(
          create: (_) => MediSchedulerListViewModel()
      ),
      ChangeNotifierProvider<MediSchedulerFormViewmodel>(
          create: (_) => MediSchedulerFormViewmodel()
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
