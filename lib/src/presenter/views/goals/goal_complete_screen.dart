import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/presenter/blocs/providers/goal_bloc.dart';
import 'package:logos/src/presenter/views/widgets/complete_list_item.dart';
import 'package:logos/src/presenter/views/widgets/typing_card.dart';

class GoalCompleteScreen extends StatelessWidget {
  const GoalCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SizedBox(height: 60),
          Padding(
            padding: EdgeInsets.all(16),
            child: TypingCard(
              text: '달성한 목표를 확인하세요!',
              icon: Icons.where_to_vote_rounded,
            ),
          ),
          BlocBuilder<GoalBloc, GoalState>(builder: goalListBuilder),
        ],
      ),
    );
  }
}

Widget goalListBuilder(BuildContext context, GoalState goals) {
  return Expanded(
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: goals.completeGoals!.length,
      itemBuilder: (context, index) => CompleteListItem(
        key: ValueKey(goals.completeGoals![index].id),
        goal: goals.completeGoals![index],
        index: index,
      ),
      separatorBuilder: (context, index) => smallVerticalSpace(),
    ),
  );
}
