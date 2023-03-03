import 'package:flutter/material.dart';
import 'package:logos/src/model/entities/goal.dart';

class CompleteCard extends StatelessWidget {
  final Function()? onPressed;
  final Goal goal;
  const CompleteCard({super.key, this.onPressed, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          width: 3,
          color: Theme.of(context).highlightColor,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          Material(
            shape: const CircleBorder(),
            clipBehavior: Clip.hardEdge,
            child: Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: onPressed != null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Theme.of(context).highlightColor,
                        width: 2,
                      ),
                    )
                  : null,
              child: Text(
                goal.priority.toString(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).highlightColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              goal.content,
              style: TextStyle(
                color: Theme.of(context).highlightColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
