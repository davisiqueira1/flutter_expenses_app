import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  const TransactionForm({
    super.key,
    required this.titleController,
    required this.valueController,
  });

  final TextEditingController titleController;
  final TextEditingController valueController;

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
                      print(titleController.text);
                      print(valueController.text);
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
