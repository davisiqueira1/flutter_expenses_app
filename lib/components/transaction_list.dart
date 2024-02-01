import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import "package:intl/intl.dart";

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required List<Transaction> transactions,
  }) : _transactions = transactions;

  final List<Transaction> _transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: _transactions
            .map(
              (Transaction t) => Card(
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Text(
                        "\$${t.value.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.yMMMEd().format(t.date),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
            .toList());
  }
}
