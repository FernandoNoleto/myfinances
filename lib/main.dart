import 'package:flutter/material.dart';
import 'package:myfinances/pages/home_page.dart';


//Firebase packages
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // options: FirebaseOptions(
    //   apiKey: "XXX",
    //   appId: "XXX",
    //   messagingSenderId: "XXX",
    //   projectId: "XXX",
    // ),
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas finanças',
      theme: ThemeData(fontFamily: 'Fredoka'),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}