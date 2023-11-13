import 'package:firebase_database/firebase_database.dart';


class FirebaseProvider{

  // ignore: slash_for_doc_comments
  /*** Referência ao caminho no banco de dados do firebase
   * */
  connection(String path){
    return FirebaseDatabase.instance.ref().child(path);
  }

  dataBaseReference(){
    return FirebaseDatabase.instance.ref();
  }


}