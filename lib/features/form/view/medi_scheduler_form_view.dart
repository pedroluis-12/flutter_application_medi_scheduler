import 'package:flutter/material.dart';
import 'package:flutter_application_medi_scheduler/commons/model/medi_scheduler_model.dart';
import 'package:provider/provider.dart';

import '../../../commons/helper/medi_scheduler_helper.dart';
import '../viewmodel/medi_scheduler_form_viewmodel.dart';

class MediSchedulerFormView extends StatefulWidget {
  const MediSchedulerFormView({super.key, this.medicineModel});

  final MediSchedulerModel? medicineModel;

  @override
  MediSchedulerFormViewState createState() => MediSchedulerFormViewState();
}

class MediSchedulerFormViewState extends State<MediSchedulerFormView> {
  final _formKey = GlobalKey<FormState>();
  final _medicineNameController = TextEditingController();
  final _timeController = TextEditingController();
  final _detailController = TextEditingController();

  bool _isNewForm = false;
  late final MediSchedulerFormViewmodel _formViewModel;

  _setFormType() {
    if (widget.medicineModel == null) {
      setState(() {
        _isNewForm = true;
      });
    } else {
      _medicineNameController.text = widget.medicineModel!.medicineName!;
      _timeController.text = widget.medicineModel!.time!;
      _detailController.text = widget.medicineModel!.description!;
    }
  }

  _initViewModel() {
    _formViewModel =
        Provider.of<MediSchedulerFormViewmodel>(context, listen: false);
  }

  _saveForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      _formViewModel.saveForm(capitalizeWords(_medicineNameController.text),
          _timeController.text, _detailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Remédio salvo com sucesso',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite todos os campos obrigatórios',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  _updateForm() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState?.save();

      _formViewModel.updateForm(
          widget.medicineModel!.id!,
          capitalizeWords(_medicineNameController.text),
          _timeController.text,
          _detailController.text);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Remédio atualizado com sucesso',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite todos os campos obrigatórios',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void initState() {
    _setFormType();
    _initViewModel();

    super.initState();
  }

  @override
  dispose() {
    _formViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              _isNewForm ? 'Adicionar Medicamento' : 'Editar Medicamento',
              style: const TextStyle(color: Colors.white)),
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
                    controller: _medicineNameController,
                    decoration: const InputDecoration(
                      hintText: "Digite o nome do remédio",
                      labelText: 'Remédio',
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 0.75,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          )),
                    ),
                    validator: (value) => _validateText(
                        value, 'Por favor, digite o nome do remédio'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _timeController,
                    decoration: const InputDecoration(
                        hintText: "Digite o horário",
                        labelText: 'Horário',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                    validator: (value) =>
                        _validateText(value, 'Por favor, digite o horário'),
                    onTap: () => showTimePicker(
                      helpText: 'Selecionar horário',
                      confirmText: 'Confirmar',
                      cancelText: 'Cancelar',
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((time) {
                      if (time != null) {
                        _timeController.text = time.format(context);
                      }
                    }),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _detailController,
                    decoration: const InputDecoration(
                        hintText: "Digite a descrição",
                        labelText: 'Descrição',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0.75,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ))),
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
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
                        onPressed: () =>
                            _isNewForm ? _saveForm() : _updateForm(),
                        child: Text(_isNewForm ? 'Salvar' : 'Atualizar',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                      )),
                ],
              ),
            ),
          );
        }));
  }

  String? _validateText(String? value, String messageError) {
    if (value == null || value.isEmpty) {
      return messageError;
    }
    return null;
  }
}
