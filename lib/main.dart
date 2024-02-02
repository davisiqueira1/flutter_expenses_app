import 'dart:math';
import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: "id1",
      title: "title1",
      value: 123.56,
      date: DateTime.now(),
    ),
    Transaction(
      id: "id2",
      title: "title2",
      value: 789.10,
      date: DateTime.now(),
    ),
  ];

  void _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () => _openFormModal(context),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              child: Card(
                elevation: 5,
                child: Text("Graph"),
              ),
            ),
            TransactionList(transactions: _transactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => _openFormModal(context),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
