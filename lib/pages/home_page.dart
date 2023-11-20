import 'package:flutter/cupertino.dart';
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
  late List<_ChartData> data;
  late TooltipBehavior _tooltip;
  // late List<Expense> listExpenses;

  @override
  void initState() {
    // listExpenses = getListExpenses();
    data = [
      _ChartData('David', 25),
      _ChartData('Steve', 38),
      _ChartData('Jack', 34),
      _ChartData('Others', 52)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  Future<List<Expense>> getListExpenses() async{
    List<Expense> listExpenses = [];
    listExpenses.add(Expense(name: 'name', value: 10, tag: Tag(color: 1000000, name: 'name')));
    return listExpenses;
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
                FutureBuilder(
                  future: getListExpenses(),
                  builder: (BuildContext context, snapshot) {
                    return SfCircularChart(
                      tooltipBehavior: _tooltip,
                      title: ChartTitle(text: 'Meus gastos'),
                      legend: const Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
                      series: <CircularSeries<_ChartData, String>>[
                        DoughnutSeries<_ChartData, String>(
                            dataSource: data,
                            explode: true,
                            xValueMapper: (_ChartData data, _) => data.x, //key: string
                            yValueMapper: (_ChartData data, _) => data.y, //value: int
                            dataLabelSettings: const DataLabelSettings(isVisible: true),
                            name: 'Gold'
                        ),
                      ],
                    );
                  }
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}

