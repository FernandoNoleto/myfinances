import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

//Providers
import 'package:myfinances/providers/firebase_provider.dart';


class HomePageController{
  DatabaseReference databaseReference = FirebaseProvider().dataBaseReference();

  Stream<DatabaseEvent> getTagsList(){
    return FirebaseProvider().dataBaseReference().child('/Tags').onValue;
  }

  Stream<DatabaseEvent> getExpensesList(){
    return FirebaseProvider().dataBaseReference().child('/Expenses').onValue;
  }

  String dateFormat(DateTime dateTime){
    //Hoje
    if(dateTime.day == DateTime.now().day){
      return "Hoje";
    }
    //Se nao for esse ano
    else if(dateTime.year != DateTime.now().year){
      return DateFormat.yMMMd().format(dateTime); //Dez 08, 2023
    }
    //Qualquer outro dia
    return DateFormat.MMMd().format(dateTime); //Jan 08
  }

}