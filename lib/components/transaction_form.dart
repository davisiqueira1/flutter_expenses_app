import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({
    required this.onPress,
    super.key,
  });

  final void Function(String, double) onPress;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  void _submitForm() {
    final String title = titleController.text;
    final double value = double.parse(valueController.text);

    if (title.isEmpty || value <= 0) {
      return;
    }

    onPress(title, value);
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
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: "Value"),
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: _submitForm,
                    child: const Text(
                      "New transaction",
                      style: TextStyle(color: Colors.purple),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
