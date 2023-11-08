import 'package:flutter/cupertino.dart';

class NewExpensePage extends StatefulWidget{
  const NewExpensePage({Key? key}) : super (key:key);

  @override
  _NewExpensePageState createState() => _NewExpensePageState();

}

class _NewExpensePageState extends State<NewExpensePage>{
  final TextEditingController _nameExpenseInputController = TextEditingController();
  final TextEditingController _valueExpenseInputController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Nova despesa'),
      ),
      child: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          onChanged: () {
            Form.maybeOf(primaryFocus!.context!)?.save();
          },
          child: CupertinoFormSection.insetGrouped(
            header: const Text('DESPESA'),
            children: <Widget>[
                CupertinoTextFormFieldRow(
                  controller: _nameExpenseInputController,
                  prefix: const Text('Nome'),
                  placeholder: 'nome do gasto',
                  validator: (String? value) {
                  if (value == null || value.isEmpty) {
                      return 'Digite o nome do gasto';
                    }
                    return null;
                  },
              ),
              CupertinoTextFormFieldRow(
                controller: _valueExpenseInputController,
                prefix: const Text('Valor'),
                placeholder: 'valor do gasto',
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite o valor do gasto';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}