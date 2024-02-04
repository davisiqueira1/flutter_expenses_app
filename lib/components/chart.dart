import 'package:expenses_app/components/chart_bar.dart';
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

        return {
          "day": DateFormat.E().format(weekDay)[0],
          "value": totalSum,
        };
      }).reversed.toList();

  double get _weekTotalValue =>
      groupedTransactions.fold(0.0, (sum, tr) => sum + (tr["value"] as double));

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions.map((Map<String, Object> t) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: t["day"].toString(),
                value: t["value"] as double,
                percentage: _weekTotalValue == 0
                    ? 0
                    : (t["value"] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
