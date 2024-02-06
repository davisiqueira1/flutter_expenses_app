import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class AdaptativeDatePicker extends StatelessWidget {
  const AdaptativeDatePicker({
    required this.selectedDate,
    required this.onDateChange,
    super.key,
  });

  final DateTime selectedDate;
  final Function(DateTime) onDateChange;

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((DateTime? pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: onDateChange,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
            ),
          )
        : SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Selected date: ${DateFormat("M/d/y").format(selectedDate)}",
                  ),
                ),
                TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: const Text("Select date"),
                )
              ],
            ),
          );
  }
}
