import 'package:firebase_database/firebase_database.dart';

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

}