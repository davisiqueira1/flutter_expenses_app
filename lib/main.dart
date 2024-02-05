import 'dart:math';
import 'package:expenses_app/components/chart.dart';
import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
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

  @override
  Widget build(BuildContext context) {
    bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      title: const Text("Expenses"),
      actions: [
        if (_isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(
              _showChart ? Icons.list : Icons.bar_chart_rounded,
              color: Colors.white,
            ),
          ),
        IconButton(
            onPressed: () => _openFormModal(context),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !_isLandscape)
              SizedBox(
                height: availableHeight * (!_isLandscape ? 0.25 : 0.7),
                child: Chart(
                  transactions: _recentTransactions,
                ),
              ),
            if (!_showChart || !_isLandscape)
              SizedBox(
                height: availableHeight * 0.75,
                child: TransactionList(
                  transactions: _transactions,
                  onDelete: _onDelete,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFormModal(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
