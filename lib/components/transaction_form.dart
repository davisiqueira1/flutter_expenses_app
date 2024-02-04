import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    required this.onPress,
    super.key,
  });

  final void Function(String, double) onPress;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  DateTime? _selectedDate;

  void _submitForm() {
    final String title = _titleController.text;
    final double value = double.parse(_valueController.text);

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onPress(title, value);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((DateTime? pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: "Title"),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Value"),
              onSubmitted: (_) => _submitForm(),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No date selected!"
                          : "Selected date: ${DateFormat("M/d/y").format(_selectedDate as DateTime)}",
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: const Text("Select date"),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _submitForm,
                  child: Text(
                    "New transaction",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelLarge!.color,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
