import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:myfinances/controllers/new_expense_controller.dart';

//Providers
import 'package:myfinances/widgets/modal_dialog_widget.dart';
import 'package:myfinances/widgets/dropdown_tags.dart';

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({Key? key}) : super(key: key);

  @override
  _NewExpensePageState createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {

  NewExpenseController newExpenseController = NewExpenseController();

  @override
  void initState() {
    newExpenseController.retrieveTagList();
    super.initState();
  }



  void _saveExpense() {}

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
          child: Column(
            children: [
              CupertinoFormSection.insetGrouped(
                header: const Text('DESPESA'),
                children: <Widget>[
                  CupertinoFormRow(
                    child: CupertinoTextFormFieldRow(
                      controller: newExpenseController.nameExpenseInputController,
                      prefix: const Text('Nome'),
                      placeholder: 'nome do gasto',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite o nome do gasto';
                        }
                        return null;
                      },
                    ),
                  ),
                  CupertinoFormRow(
                    child: CupertinoTextFormFieldRow(
                      controller: newExpenseController.valueExpenseInputController,
                      prefix: const Text('Valor'),
                      placeholder: 'valor do gasto',
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Digite o valor do gasto';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              CupertinoFormSection.insetGrouped(
                header: const Text('TAG'),
                children: <Widget>[
                  CupertinoFormRow(
                    child: Row(
                      children: [
                        CupertinoButton(
                            child: const Row(
                              children: [
                                Icon(CupertinoIcons.add_circled_solid),
                                SizedBox(width: 2,),
                                Text('Nova tag'),
                              ],
                            ), onPressed: () {}),
                        const Spacer(),
                        CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => ModalDialogProvider().showDialog(
                                  CupertinoPicker(
                                    magnification: 1.22,
                                    squeeze: 1.2,
                                    useMagnifier: true,
                                    itemExtent: 32.0,
                                    scrollController: FixedExtentScrollController(
                                      initialItem: newExpenseController.selectedTag,
                                    ),
                                    onSelectedItemChanged: (int selectedItem) {
                                      setState(() {
                                        newExpenseController.selectedTag = selectedItem;
                                      });
                                    },
                                    children: List<Widget>.generate(
                                        newExpenseController.dropdownList.length, (int index) {
                                        return Center(child: newExpenseController.dropdownList[index]);
                                    }),
                                  ),
                                  context,
                                ),
                            // This displays the selected fruit name.
                            child: newExpenseController.dropdownList[newExpenseController.selectedTag]),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CupertinoButton.filled(
                onPressed: () {
                  _saveExpense();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
