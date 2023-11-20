import 'package:flutter/material.dart';
import 'package:myfinances/entities/expense.dart';

//Entities
import 'package:myfinances/entities/tag.dart';

//Providers
import 'package:myfinances/providers/firebase_provider.dart';


//Widgets
// import 'package:myfinances/widgets/dropdown_tags_widget.dart';

class NewExpenseController{
  final TextEditingController nameExpenseInputController = TextEditingController();
  final TextEditingController valueExpenseInputController = TextEditingController();

  void addNewTag(String name, int color) async{
    Tag tag = Tag(name: name, color: color);
    final tagReference = FirebaseProvider().connection('/Tags/${tag.name}');
    try{
      await tagReference.update(tag.toJson());
    } catch (error){
      debugPrint("Erro: $error");
    }

  }
  void saveExpense(String name, int value, Tag tag) async {
    Expense expense = Expense(name: name, value: value, tag: tag);
    debugPrint(''' Expense:
    name: ${expense.name}
    value: ${expense.value}
    tag: ${expense.tag.name} ${expense.tag.color}
    ''');

    final tagReference = FirebaseProvider().connection('/Expenses/${expense.name}');
    try{
      await tagReference.update(expense.toJson());
    } catch (error){
      debugPrint("Erro: $error");
    }

  }
}