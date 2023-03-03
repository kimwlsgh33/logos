import 'package:flutter/material.dart';

class CancelContainer extends StatelessWidget {
  const CancelContainer ({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).splashColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(
            Icons.replay_circle_filled_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
