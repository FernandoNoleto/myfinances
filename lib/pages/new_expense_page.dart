import 'dart:convert';
import 'dart:core';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

//Controllers
import 'package:myfinances/controllers/new_expense_controller.dart';
import 'package:myfinances/providers/firebase_provider.dart';

//Widgets
import 'package:myfinances/widgets/dropdown_tags_widget.dart';
import 'package:myfinances/widgets/modal_dialog_widget.dart';

//Entities
import 'package:myfinances/entities/tag.dart';


class NewExpensePage extends StatefulWidget {
  const NewExpensePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NewExpensePageState createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  NewExpenseController newExpenseController = NewExpenseController();
  late int selectedTagIndex;
  late Color selectedColor;
  late Tag selectedTag;
  late List<Tag> tagList = [];
  final TextEditingController nameTagInputController = TextEditingController();


  @override
  void initState() {
    selectedTagIndex = 0;
    selectedColor = Colors.red;
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
                      autofocus: true,
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
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(20),
                                                ],
                                              ),
                                            ),
                                          ),
                                          BlockPicker(
                                            pickerColor: Colors.red,
                                            onColorChanged: (Color color) {
                                              setState(() {
                                                selectedColor = color;
                                              });
                                            },
                                          ),
                                          Icon(
                                            //TODO: Icon não está atualizando a cor conforme seleciona uma cor diferente no BlockPicker
                                            CupertinoIcons.tag_fill,
                                            color: selectedColor,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        CupertinoButton(
                                          child: const Text('Confirmar'),
                                          onPressed: () {
                                            if(nameTagInputController.text != ""){
                                              Navigator.pop(context);
                                              NewExpenseController().addNewTag(
                                                nameTagInputController.text,
                                                selectedColor.value
                                              );
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
                        StreamBuilder(
                          stream: FirebaseProvider().dataBaseReference().child('/Tags').onValue,
                          builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CupertinoActivityIndicator();
                            } else {
                              final Map<String,dynamic> myTags = Map<String,dynamic>.from(jsonDecode(jsonEncode((snapshot.data!).snapshot.value)));
                              final List<Widget> dropdownlist = [];

                              myTags.forEach((key, value) {
                                final nextTag = Map<String, dynamic>.from(value);
                                final tag = Tag(name: nextTag['name'], color: nextTag['color']);
                                tagList.add(tag);
                                // debugPrint("${nextTag['name']}: ${nextTag['color']}");
                                dropdownlist.add(DropdownTags(tag: tag));
                              });
                              return CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => ModalDialogProvider().showDialog(
                                    CupertinoPicker(
                                      magnification: 1.22,
                                      squeeze: 1.2,
                                      useMagnifier: true,
                                      itemExtent: 32.0,
                                      scrollController:
                                      FixedExtentScrollController(initialItem: dropdownlist.length,),
                                      onSelectedItemChanged: (int selectedItem) {
                                        setState(() {
                                          selectedTagIndex = selectedItem;
                                          selectedTag = tagList[selectedTagIndex];
                                        });
                                      },
                                      children: List<Widget>.generate(dropdownlist.length, (int index) {
                                        return Center(
                                            child: dropdownlist[index],
                                        );
                                      }),
                                    ),
                                    context,
                                  ),
                                  child: dropdownlist[selectedTagIndex]
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
                  newExpenseController.saveExpense(
                    newExpenseController.nameExpenseInputController.text,
                    int.parse(newExpenseController.valueExpenseInputController.text),
                    tagList[selectedTagIndex],
                  );
                  showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: const Text('Nova despesa lançada!'),
                        actions: <CupertinoDialogAction>[
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              Navigator.pop(context);
                              newExpenseController.nameExpenseInputController.clear();
                              newExpenseController.valueExpenseInputController.clear();
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    }
                  );
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
