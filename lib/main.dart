import 'dart:math';
import 'dart:io';
import 'package:expenses_app/components/chart.dart';
import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  ExpensesApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: theme.textTheme.copyWith(
          titleLarge: const TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          labelLarge: const TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions => _transactions
      .where(
        (t) => t.date.isAfter(
          DateTime.now().subtract(
            const Duration(days: 7),
          ),
        ),
      )
      .toList();

  void _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _onDelete(String id) {
    setState(() {
      _transactions.removeWhere((Transaction t) => t.id == id);
    });
  }

  void _openFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext _) {
        return TransactionForm(onPress: _addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, void Function() fn) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: fn,
            child: Icon(icon),
          )
        : IconButton(
            onPressed: fn,
            icon: Icon(
              icon,
              color: Colors.white,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = [
      if (isLandscape)
        _getIconButton(
          _showChart
              ? (Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list)
              : (Platform.isIOS
                  ? CupertinoIcons.chart_bar_alt_fill
                  : Icons.bar_chart_rounded),
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openFormModal(context),
      )
    ];

    final appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text("Expenses"),
      actions: actions,
    );

    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (!isLandscape ? 0.25 : 0.7),
                child: Chart(
                  transactions: _recentTransactions,
                ),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (!isLandscape ? 0.75 : 1),
                child: TransactionList(
                  transactions: _transactions,
                  onDelete: _onDelete,
                ),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text("Expenses"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    onPressed: () => _openFormModal(context),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
