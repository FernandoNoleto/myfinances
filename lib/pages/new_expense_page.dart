import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

//Controllers
import 'package:myfinances/controllers/new_expense_controller.dart';

//Widgets
import 'package:myfinances/widgets/modal_dialog_widget.dart';

//Entities
import '../entities/tag.dart';


class NewExpensePage extends StatefulWidget {
  const NewExpensePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewExpensePageState createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  NewExpenseController newExpenseController = NewExpenseController();
  late Future<List<Widget>>? listOfTags;
  late int selectedTag;
  late Color colorSelected;
  final TextEditingController nameTagInputController = TextEditingController();


  @override
  void initState() {
    selectedTag = 0;
    colorSelected = Colors.red;
    listOfTags = newExpenseController.getTagsWidgetsList();
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
              //DESPESA FORM
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
              //CATEGORIA FORM
              CupertinoFormSection.insetGrouped(
                header: const Text('CATEGORIA'),
                children: <Widget>[
                  CupertinoFormRow(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //ADD TAG
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
                                    return CupertinoAlertDialog(
                                      content: Column(
                                        children: [
                                          Form(
                                            child: CupertinoFormRow(
                                              child: CupertinoTextFormFieldRow(
                                                placeholder: 'Nome da nova categoria',
                                                controller: nameTagInputController,
                                                validator: (String? value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Digite o nome da nova categoria';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          BlockPicker(
                                            pickerColor: Colors.red,
                                            onColorChanged: (Color color) {
                                              setState(() {
                                                colorSelected = color;
                                              });
                                            },
                                          ),
                                          Icon(
                                            CupertinoIcons.tag_fill,
                                            color: colorSelected,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        CupertinoButton(
                                            child: const Text('Confirmar'),
                                            onPressed: () {
                                              if(nameTagInputController.text != ""){
                                                Navigator.pop(context);
                                                NewExpenseController().addNewTag(Tag(name: nameTagInputController.text, color: colorSelected.value));
                                                setState(() {
                                                  listOfTags = newExpenseController.getTagsWidgetsList();
                                                });
                                              }
                                              else{

                                              }
                                            }
                                        ),
                                        CupertinoButton(
                                            child: const Text('Cancelar'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }
                                        ),
                                      ],
                                    );
                                  }
                              );
                            }
                        ),
                        //DROPDOWN TAGS
                        FutureBuilder<List<Widget>>(
                          future: listOfTags,
                          builder: (context, snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CupertinoActivityIndicator();
                            } else {
                              debugPrint("snapshot: ${snapshot.data}");
                              return CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => ModalDialogProvider().showDialog(
                                    CupertinoPicker(
                                      magnification: 1.22,
                                      squeeze: 1.2,
                                      useMagnifier: true,
                                      itemExtent: 32.0,
                                      scrollController:
                                      FixedExtentScrollController(initialItem: snapshot.data!.length,),
                                      onSelectedItemChanged: (int selectedItem) {
                                        setState(() {
                                          selectedTag = selectedItem;
                                        });
                                      },
                                      children: List<Widget>.generate(snapshot.data!.length, (int index) {
                                        return Center(
                                            child: snapshot.data![index]
                                        );
                                      }),
                                    ),
                                    context,
                                  ),
                                  child: snapshot.data![selectedTag]
                              );
                            }
                          },
                        ),
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
