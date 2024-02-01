import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({
    required this.onPress,
    super.key,
  });

  final void Function(String, double) onPress;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

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
            ),
            TextField(
              controller: valueController,
              decoration: const InputDecoration(labelText: "Value"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      final String title = titleController.text;
                      final double value = double.parse(valueController.text);
                      onPress(title, value);
                    },
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
