import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/presenter/blocs/providers/goal_bloc.dart';
import 'package:logos/src/presenter/views/goals/components/complete_card.dart';
import 'package:logos/src/presenter/views/widgets/cancel_container.dart';
import 'package:logos/src/presenter/views/widgets/error_container.dart';

class CompleteListItem extends StatelessWidget {
  const CompleteListItem({
    super.key,
    required this.goal,
    required this.index,
  });

  final Goal goal;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoalBloc, GoalState>(builder: (context, goals) {
      return Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          Dismissible(
            key: Key(goal.id),
            background: const CancelContainer(),
            secondaryBackground: const ErrorContainer(),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                // logic for delete
                context.read<GoalBloc>().add(RemoveGoalEvent(goal));
                Get.snackbar(
                  '삭제 완료',
                  "목표가 삭제되었습니다.",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              } else {
                context.read<GoalBloc>().add(CancelGoalCompleteEvent(goal));
                Get.snackbar(
                  '취소 완료',
                  "목표를 복구하셨습니다.",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Theme.of(context).splashColor,
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              }
            },
            confirmDismiss: (direction) {
              if (direction == DismissDirection.endToStart) {
                return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("삭제하시겠습니까?",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          content: Text("더 이상 복구할수 없습니다.",
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text("삭제"),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text("취소"),
                            ),
                          ],
                        ));
              } else {
                return showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("목표 복구",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface)),
                    content: Text("목표를 복구하시겠습니까?",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface)),
                    actions: [
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("복구"),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("닫기"),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Hero(
              tag: goal.id,
              child: CompleteCard(goal: goal, onPressed: () {}),
            ),
          ),
        ],
      );
    });
  }
}
