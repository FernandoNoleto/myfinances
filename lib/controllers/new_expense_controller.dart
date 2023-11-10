import 'package:flutter/cupertino.dart';

import '../widgets/dropdown_tags.dart';

class NewExpenseController{

  final TextEditingController nameExpenseInputController = TextEditingController();
  final TextEditingController valueExpenseInputController = TextEditingController();

  final List<Widget> dropdownList = [];
  int selectedTag = 0;


  //Aqui vai a função de recuperar a lista de tags já existentes
  void retrieveTagList() {
    dropdownList.add(const DropdownTags(color: CupertinoColors.destructiveRed, tag: 'Supermercado'));
    dropdownList.add(const DropdownTags(color: CupertinoColors.extraLightBackgroundGray, tag: 'Bar/Restaurantes'));
    dropdownList.add(const DropdownTags(color: CupertinoColors.link, tag: 'Compras na internet'));
  }



}