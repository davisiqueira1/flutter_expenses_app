import 'package:expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({required List<Transaction> transactions, super.key})
      : _recentTransactions = transactions;

  final List<Transaction> _recentTransactions;

  List<Map<String, Object>> get groupedTransactions =>
      List.generate(7, (index) {
        final DateTime weekDay = DateTime.now().subtract(Duration(days: index));

        double totalSum = 0;

        for (int i = 0; i < _recentTransactions.length; i++) {
          bool sameDay = _recentTransactions[i].date.day == weekDay.day;
          bool sameMonth = _recentTransactions[i].date.month == weekDay.month;
          bool sameYear = _recentTransactions[i].date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += _recentTransactions[i].value;
          }
        }

        print(DateFormat.E().format(weekDay)[0]);
        print(totalSum);

        return {
          "day": DateFormat.E().format(weekDay)[0],
          "value": totalSum,
        };
      }); // just a placeholder value

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return const Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: [],
      ),
    );
  }
}
