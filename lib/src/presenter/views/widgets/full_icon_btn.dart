
import 'package:flutter/material.dart';

class FullIconBtn extends StatelessWidget {
  final IconData icon;
  final Function() onTap;
  final Color bgColor;
  final Color color;

  const FullIconBtn({
    super.key,
    required this.icon,
    required this.onTap,
    required this.color,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        splashColor: Colors.red,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8),
            backgroundBlendMode: BlendMode.multiply,
          ),
          child: Icon(
            Icons.add_rounded,
            color: color,
            size: 40,
          ),
        ),
      ),
    );
  }
}
