import 'package:expenses_app/components/transaction_item.dart';
import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required List<Transaction> transactions,
    required Function(String id) onDelete,
  })  : _transactions = transactions,
        _onDelete = onDelete;

  final List<Transaction> _transactions;
  final Function(String id) _onDelete;

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                    child: Text(
                      "No transactions registered!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.05,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: const Image(
                      image: AssetImage(
                        'assets/images/waiting.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (ctx, index) {
              final Transaction t = _transactions[index];
              return TransactionItem(transaction: t, onDelete: _onDelete);
            },
          );
  }
}
