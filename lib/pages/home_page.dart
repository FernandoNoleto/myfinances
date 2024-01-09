import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfinances/controllers/home_page_controller.dart';
import 'package:myfinances/entities/expense.dart';
import 'package:myfinances/entities/tag.dart';
import 'package:myfinances/pages/new_expense_page.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
  late List<Tag> listTags = [];
  late List<Expense> listExpenses = [];

  @override
  void initState() {
    listTags.clear();
    listExpenses.clear();
    tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Minhas Finanças'),
            trailing: CupertinoButton(
              child: const Icon(
                CupertinoIcons.add
              ),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const NewExpensePage()));
            }),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder(
                    stream: HomePageController().getTagsList(),
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CupertinoActivityIndicator();
                      } else {
                        try{
                          // debugPrint('${snapshot.data}');
                          listTags.clear();
                          final Map<String,dynamic> myTags = Map<String,dynamic>.from(jsonDecode(jsonEncode((snapshot.data!).snapshot.value)));
                          myTags.forEach((key, value) {
                            final nextTag = Map<String, dynamic>.from(value);
                            // debugPrint("name: ${nextTag['name']}, color: ${nextTag['color']}, totalValue: ${nextTag['totalValue']}");
                            Tag tag = Tag(name: nextTag['name'], color: nextTag['color'], totalValue: nextTag['totalValue'].toDouble());
                            listTags.add(tag);
                          });
                          return SfCircularChart(
                            tooltipBehavior: tooltip,
                            // title: ChartTitle(text: 'Meus gastos'),
                            legend: const Legend(isVisible: true, overflowMode: LegendItemOverflowMode.scroll),
                            series: <CircularSeries<Tag, String>>[
                              DoughnutSeries<Tag, String>(
                                dataSource: listTags,
                                explode: true,
                                pointColorMapper: (Tag tag, _) => Color(tag.color),
                                xValueMapper: (Tag tag, _) => tag.name, //key: Nome da tag
                                yValueMapper: (Tag tag, _) => tag.totalValue, //value: Valor total daquela tag
                                dataLabelSettings: const DataLabelSettings(isVisible: true),
                              ),
                            ],
                          );
                        } catch(error) { // Quando não há nenhum gasto lançado
                          debugPrint("Erro: $error");
                          return const Text('Não há dados');
                        }
                      }
                    },
                  ),
                  StreamBuilder(
                    stream: HomePageController().getExpensesList(),
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CupertinoActivityIndicator();
                      }
                      else{
                        try{
                          // debugPrint('${snapshot.data}');
                          listExpenses.clear();
                          final Map<String,dynamic> myExpenses = Map<String,dynamic>.from(jsonDecode(jsonEncode((snapshot.data!).snapshot.value)));
                          myExpenses.forEach((key, value) {
                            final nextExpense = Map<String, dynamic>.from(value);

                            //Mapeando a Tag dentro de Expense
                            final nextTag = Map<String, dynamic>.from(nextExpense['tag']);
                            Tag tag = Tag(name: nextTag['name'], color: nextTag['color'], totalValue: nextTag['totalValue'].toDouble());

                            Expense expense = Expense(name: nextExpense['name'], tag: tag, value: nextExpense['value'], pathFile: 'pathFile');
                            listExpenses.add(expense);
                          });
                          //Lista de historico de consumo
                          return CupertinoListSection(
                            header: const Text('Historico'),
                            children: List.generate(
                              listExpenses.length, (index) => CupertinoListTile(
                              title: Text(listExpenses[index].name),
                              additionalInfo: Text("R\$: ${listExpenses[index].value.toStringAsFixed(2)}"),
                              leading: Container(
                                decoration: BoxDecoration(
                                    color: Color(listExpenses[index].tag.color),
                                    shape: BoxShape.circle
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        catch(error){
                          debugPrint("Erro: $error");
                          return const Text('Não há dados');
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//TODO: Criar função de deletar gasto cadastrado no BD

