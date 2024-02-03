import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({
    required double value,
    required double percentage,
    required String label,
    super.key,
  })  : _percentage = percentage,
        _label = label,
        _value = value;

  final double _value;
  final double _percentage;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(_value.toStringAsFixed(2)),
        const SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: null,
        ),
        const SizedBox(height: 5),
        Text(_label),
      ],
    );
  }
}
