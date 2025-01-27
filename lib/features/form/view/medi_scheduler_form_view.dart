import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/medi_scheduler_form_viewmodel.dart';

class MediSchedulerFormView extends StatefulWidget {
  const MediSchedulerFormView({super.key});

  @override
  MediSchedulerFormViewState createState() => MediSchedulerFormViewState();
}

class MediSchedulerFormViewState extends State<MediSchedulerFormView> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Adicionar Medicamento',
              style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.lightBlue,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Consumer<MediSchedulerFormViewmodel>(
            builder: (context, viewModel, child) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: "Enter the title",
                      labelText: 'title',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.75,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _detailController,
                    decoration: const InputDecoration(
                        hintText: "Enter the description",
                        labelText: 'Description',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.all(20),
                        ),
                        onPressed: () => _saveForm(viewModel),
                        child: const Text('Salvar',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                      )),
                ],
              ),
            ),
          );
        }));
  }

  _saveForm(MediSchedulerFormViewmodel viewModelObservable) {
    Provider.of<MediSchedulerFormViewmodel>(context, listen: false)
        .saveForm(_titleController.text, _detailController.text);
        
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Remédio salvo com sucesso'),
          backgroundColor: Colors.greenAccent,
        ),
      );
      Navigator.pop(context);
  }
}
