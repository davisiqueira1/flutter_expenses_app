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
    return SizedBox(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "No transactions registered!",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  height: 200,
                  child: const Image(
                    image: AssetImage(
                      'assets/images/waiting.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, index) {
                final Transaction t = _transactions[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.all(5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            "\$${t.value}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      t.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(DateFormat('d MMM y').format(t.date)),
                  ),
                );
              },
            ),
    );
  }
}
