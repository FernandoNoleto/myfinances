import 'dart:core';
import 'package:flutter/cupertino.dart';

//Controllers
import 'package:myfinances/controllers/new_expense_controller.dart';

//Widgets
import 'package:myfinances/widgets/new_tag_dialog_widget.dart';

//Entities
import 'package:myfinances/widgets/modal_dialog_widget.dart';

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
                      maxLength: 18,
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
                      controller:
                          newExpenseController.valueExpenseInputController,
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
                header: const Text('CATEGORIA'),
                children: <Widget>[
                  CupertinoFormRow(
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton(
                            child: const Row(
                              children: [
                                Icon(CupertinoIcons.add_circled_solid),
                                SizedBox(width: 2,),
                                Text('Categoria'),
                              ],
                            ),
                            onPressed: () {
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const NewTagDialog();
                                });
                        }),
                        newExpenseController.dropdownList.isNotEmpty ? CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => ModalDialogProvider().showDialog(
                              CupertinoPicker(
                                magnification: 1.22,
                                squeeze: 1.2,
                                useMagnifier: true,
                                itemExtent: 32.0,
                                scrollController:
                                FixedExtentScrollController(initialItem: newExpenseController.selectedTag,
                                ),
                                onSelectedItemChanged: (int selectedItem) {
                                  setState(() {
                                    newExpenseController.selectedTag = selectedItem;
                                  });
                                },
                                children: List<Widget>.generate(
                                    newExpenseController.dropdownList.length, (int index) {
                                  return Center(
                                      child: newExpenseController.dropdownList[index]);
                                }),
                              ),
                              context,
                            ),
                            // This displays the selected fruit name.
                            child: newExpenseController.dropdownList[newExpenseController.selectedTag]
                        ) :
                        const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CupertinoButton.filled(
                onPressed: () {
                  newExpenseController.saveExpense();
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
