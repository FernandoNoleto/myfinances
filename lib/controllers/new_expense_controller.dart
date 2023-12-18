import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:myfinances/entities/expense.dart';

//Entities
import 'package:myfinances/entities/tag.dart';

//Providers
import 'package:myfinances/providers/firebase_provider.dart';

class NewExpenseController{
  final TextEditingController nameExpenseInputController = TextEditingController();
  final TextEditingController valueExpenseInputController = TextEditingController();

  void addNewTag(String name, int color) async{
    Tag tag = Tag(name: name, color: color, totalValue: 0);
    final tagReference = FirebaseProvider().connection('/Tags/${tag.name}');
    try{
      await tagReference.update(tag.toJson());
    } catch (error){
      debugPrint("Erro: $error");
    }

  }

  void saveExpense(String name, int value, Tag tag, String pathFile) async {
    Expense expense = Expense(name: name, value: value, tag: tag, pathFile: pathFile);
    // debugPrint(''' Expense:
    // name: ${expense.name}
    // value: ${expense.value}
    // tag: ${expense.tag.name} ${expense.tag.color}
    // ''');

    final tagReference = FirebaseProvider().connection('/Expenses/${expense.name}');
    try{
      await tagReference.update(expense.toJson());
    } catch (error){
      debugPrint("Erro: $error");
    }

  }

  void sumValueToTag(int value, String nameTag) async{
    final tagReference = FirebaseProvider().connection('/Tags/$nameTag');
    FirebaseProvider().connection('/Tags/$nameTag/totalValue').once().then((DatabaseEvent snapshot) async {
      if(snapshot.snapshot.exists){
        int tagTotalValue = snapshot.snapshot.value as int;
        try{
          await tagReference.update({'totalValue': tagTotalValue + value});
        } catch (error){
          debugPrint("Erro: $error");
        }
      }
    });

  }
}