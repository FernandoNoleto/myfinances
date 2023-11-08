import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:myfinances/pages/new_expense_page.dart';
import 'package:myfinances/providers/container_provider.dart';

void main() {
  runApp(const CupertinoApp(
    title: 'Minhas finanças',
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List getListExpenses(){
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Minhas finanças'),
      ),
      child: SafeArea(
        child: getListExpenses() == [] ?
        const Text('tem despesas lançadas')
            :
        Column(
          children: [
            const Text('Nao nada por aqui'),
            Center(
              child: CupertinoButton(
                  child: const Text('Lançar nova despesa'),
                  onPressed: () {
                    Navigator.push(context, CupertinoPageRoute(builder: (context) => const NewExpensePage()),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
