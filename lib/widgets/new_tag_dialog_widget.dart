import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myfinances/controllers/new_expense_controller.dart';
import 'package:myfinances/entities/tag.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({Key? key}) : super(key: key);

  @override
  _NewTagDialogState createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late Color colorSelected = Colors.red;
  late TextEditingController nameTagInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        children: [
          Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoFormRow(
                  child: CupertinoTextFormFieldRow(
                    // prefix: const Text('Nome'),
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
              ],
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
              if(nameTagInputController.text != null && nameTagInputController.text != ""){
                Navigator.pop(context);
                NewExpenseController().addNewTag(Tag(name: nameTagInputController.text, color: colorSelected.value));
              }
              else{

              }
            }),
        CupertinoButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.pop(context);
            }),
      ],
    );
  }
}
