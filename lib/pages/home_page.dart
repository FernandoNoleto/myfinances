import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfinances/controllers/home_page_controller.dart';
import 'package:myfinances/entities/tag.dart';
import 'package:myfinances/pages/new_expense_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

//Entities
import 'package:myfinances/entities/expense.dart';

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
  late TooltipBehavior tooltip;
  late List<Expense> listExpenses = [];

  @override
  void initState() {
    tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Minhas finanças'),
            trailing: CupertinoButton(
              child: const Icon(
                CupertinoIcons.add
              ),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const NewExpensePage()));
            }),
          ),
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StreamBuilder(
                  stream: HomePageController().getExpensesList(),
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    } else {
                      final Map<String,dynamic> myExpenses = Map<String,dynamic>.from(jsonDecode(jsonEncode((snapshot.data!).snapshot.value)));
                      myExpenses.forEach((key, value) {
                        final nextExpense = Map<String, dynamic>.from(value);
                        Expense expense = Expense(name: nextExpense['name'], value: nextExpense['value'], tag: Tag.fromJson(nextExpense['tag']));
                        debugPrint('$expense');
                        listExpenses.add(expense);
                      });
                      return SfCircularChart(
                        tooltipBehavior: tooltip,
                        title: ChartTitle(text: 'Meus gastos'),
                        legend: const Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
                        series: <CircularSeries<Expense, String>>[
                          DoughnutSeries<Expense, String>(
                            dataSource: listExpenses,
                            explode: true,
                            xValueMapper: (Expense expense, _) => expense.name, //key: string
                            yValueMapper: (Expense expense, _) => expense.value, //value: int
                            dataLabelSettings: const DataLabelSettings(isVisible: true),
                            strokeColor: CupertinoColors.activeGreen,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


