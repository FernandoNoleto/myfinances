
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfinances/entities/tag.dart';
import 'package:myfinances/providers/firebase_provider.dart';


//Widgets
import 'package:myfinances/widgets/dropdown_tags_widget.dart';


import 'package:myfinances/providers/firebase_provider.dart';


class NewExpenseController{
  final TextEditingController nameExpenseInputController = TextEditingController();
  final TextEditingController valueExpenseInputController = TextEditingController();

  late List<Widget> dropdownList = [];
  int selectedTag = 0;


  //Aqui vai a função de recuperar a lista de tags já existentes
  void retrieveTagList(){

    // List<Widget> dropdownList = [];

    final firebaseDatabase = FirebaseDatabase.instance.ref();

    // dropdownList.add(const DropdownTags(color: Colors.cyan, tag: 'tag'));

    Tag tag;
    List<Tag> tagsList = [];
    firebaseDatabase.child("/Tags/").onValue.listen((event) async {
      final objects = event.snapshot.children;
      for (var object in objects) {
        tag = Tag.fromJson(jsonDecode(jsonEncode(Map<String, dynamic>.from(object.value as Map<dynamic, dynamic>))));
        tagsList.add(tag);
      }

      for(Tag tag in tagsList){
        dropdownList.add(DropdownTags(color: Color(tag.color), tag: tag.name));
      }

    });

  }

  int getHexFromColor(Color color){
    return color.value;
  }

  void addNewTag(Tag tag) async{
    final tagReference = FirebaseProvider().connection('/Tags/${tag.name}');
    try{
      await tagReference.update(tag.toJson());
      ("Tag cadastrado no bd de exercicios!");
    } catch (error){
      print("Deu o seguinte erro: $error");
    }




  }
  void saveExpense() {}
}