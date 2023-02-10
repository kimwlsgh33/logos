
import 'package:flutter/material.dart';

class SuccessContainer extends StatelessWidget {
  const SuccessContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
