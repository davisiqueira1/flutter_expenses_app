import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  const AdaptativeButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            color: Theme.of(context).colorScheme.primary,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(label),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).textTheme.labelLarge!.color,
              ),
            ),
          );
  }
}
