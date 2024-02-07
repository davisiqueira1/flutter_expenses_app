import 'package:expenses_app/components/adaptative_button.dart';
import 'package:expenses_app/components/adaptative_date_picker.dart';
import 'package:expenses_app/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    required this.onPress,
    super.key,
  });

  final void Function(String, double, DateTime) onPress;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final String title = _titleController.text;
    final double value = double.parse(_valueController.text);

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onPress(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                controller: _titleController,
                label: "Title",
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeTextField(
                controller: _valueController,
                label: "Value",
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChange: (DateTime date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: "New transaction",
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
