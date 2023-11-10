import 'package:flutter/cupertino.dart';
import 'package:myfinances/pages/new_expense_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      theme: CupertinoThemeData(brightness: Brightness.light),
      home: HomePageState(),
    );
  }
}

class HomePageState extends StatefulWidget {
  const HomePageState({super.key});

  @override
  State<HomePageState> createState() => _HomePageStateState();
}

class _HomePageStateState extends State<HomePageState> {
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
