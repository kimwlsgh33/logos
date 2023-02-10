import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/presenter/views/goals/goal_edit_screen.dart';
import '../../../../model/entities/goal.dart';

class AnswerCard extends StatelessWidget {
  final Function()? onPressed;
  final Goal goal;
  final bool isDetail;
  const AnswerCard({
    super.key,
    this.onPressed,
    required this.goal,
    this.isDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(8),
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBackgroundColor: Theme.of(context).colorScheme.primary,
          disabledForegroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            Material(
              shape: const CircleBorder(),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () => Get.to(
                  GoalEditScreen(goal: goal),
                  transition: Transition.circularReveal,
                  duration: const Duration(milliseconds: 650),
                ),
                child: Container(
                  width: 35,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: onPressed != null
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        )
                      : null,
                  child: Text(
                    goal.priority.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                goal.content,
                style: const TextStyle(
                  fontSize: 18,
                  // fontWeight: FontWeight.w700,
                ),
                maxLines: 3,
              ),
            ),
            smallHorizontalSpace(),
            if (onPressed != null)
              Text(
                goal.done ? '완료' : '미완료',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: goal.done
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
