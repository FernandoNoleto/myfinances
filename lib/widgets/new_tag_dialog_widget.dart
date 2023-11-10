import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myfinances/controllers/new_expense_controller.dart';

class NewTagDialog extends StatefulWidget {
  const NewTagDialog({Key? key}) : super(key: key);

  @override
  _NewTagDialogState createState() => _NewTagDialogState();
}

class _NewTagDialogState extends State<NewTagDialog> {
  late Color colorSelected = Colors.red;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      // title: const Text('Criar nova categoria'),
      content: Column(
        children: [
          Form(
            child: CupertinoFormRow(
              child: CupertinoTextFormFieldRow(
                prefix: const Text('Nome'),
                placeholder: 'Nome da nova categoria',
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
            child: const Text('ok'),
            onPressed: () {
              Navigator.pop(context);
              NewExpenseController().addNewTag();
            }),
      ],
    );
  }
}
