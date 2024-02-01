import 'package:expenses_app/components/transaction_form.dart';
import 'package:expenses_app/components/transaction_list.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionUser extends StatefulWidget {
  const TransactionUser({super.key});

  @override
  State<TransactionUser> createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionList(transactions: _transactions),
        TransactionForm(
            titleController: titleController, valueController: valueController)
      ],
    );
  }
}
