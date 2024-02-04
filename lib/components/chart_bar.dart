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
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5)),
              ),
              FractionallySizedBox(
                heightFactor: _percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(_label),
      ],
    );
  }
}
