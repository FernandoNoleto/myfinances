import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';

//Entities
import 'package:myfinances/entities/tag.dart';

//Providers
import 'package:myfinances/providers/firebase_provider.dart';


//Widgets
import 'package:myfinances/widgets/dropdown_tags_widget.dart';

class NewExpenseController{
  final TextEditingController nameExpenseInputController = TextEditingController();
  final TextEditingController valueExpenseInputController = TextEditingController();

  //Aqui vai a função de recuperar a lista de tags já existentes
   Future<List<Widget>> retrieveTagList() async {
    List<Widget> dropdownlist = [];
    List<Tag> tagsList = [];

    FirebaseProvider().dataBaseReference().child("/Tags").onValue.listen((event) {
      final objects = event.snapshot.children;
      for (DataSnapshot object in objects) {
        Tag tag = Tag.fromJson(jsonDecode(jsonEncode(Map<String, dynamic>.from(object.value as Map<dynamic, dynamic>))));
        tagsList.add(tag);
      }
      for(Tag tag in tagsList){
        dropdownlist.add(
          DropdownTags(
              color: Color(tag.color), tag: tag.name,
          ),
        );
      }
    });

    return dropdownlist;
  }


  void addNewTag(Tag tag) async{
    final tagReference = FirebaseProvider().connection('/Tags/${tag.name}');
    try{
      await tagReference.update(tag.toJson());
    } catch (error){
      debugPrint("Erro: $error");
    }

  }
  void saveExpense() {

  }
}