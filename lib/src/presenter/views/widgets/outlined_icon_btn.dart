
import 'package:flutter/material.dart';

class OutlinedIconBtn extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final Color color;

  const OutlinedIconBtn({
    super.key,
    required this.icon,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      elevation: 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: color,
          ),
        ),
      ),
    );
  }
}
