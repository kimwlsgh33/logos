import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/presenter/blocs/providers/reason_bloc.dart';
import 'package:logos/src/presenter/views/goals/components/anwser_card.dart';
import 'package:logos/src/presenter/views/widgets/full_row_textfield.dart';
import 'package:logos/src/presenter/views/widgets/goal_btn_bar.dart';
import 'package:logos/src/presenter/views/widgets/reason_list_item.dart';
import 'package:logos/src/presenter/views/widgets/typing_card.dart';

class GoalReasonScreen extends StatefulWidget {
  Goal goal;
  GoalReasonScreen({super.key, required this.goal});

  @override
  State<GoalReasonScreen> createState() => _GoalReasonScreenState();
}

class _GoalReasonScreenState extends State<GoalReasonScreen> {
  final TextEditingController _controller = TextEditingController();
  onAdd(String value) => context
      .read<ReasonBloc>()
      .add(AddReasonEvent(value, goalId: widget.goal.id));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TypingCard(text: '이게 왜 중요한가?'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Hero(
                    tag: widget.goal.id,
                    child: AnswerCard(
                      goal: widget.goal,
                      isReason: true,
                    ),
                  ),
                ),
                smallVerticalSpace(),
                FullRowTextField(
                  controller: _controller,
                  hintText: '이유를 입력해주세요',
                  onSubmitted: onAdd,
                ),
                smallVerticalSpace(),
                Hero(
                  tag: 'goalBtnBar',
                  child: GoalBtnBar(
                    controller: _controller,
                    onAdd: onAdd,
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ReasonBloc, ReasonState>(
            builder: (context, state) {
              final reasons = state.reasons!
                  .where((reason) => reason.goalId == widget.goal.id)
                  .toList();
              return Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: reasons.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      smallVerticalSpace(),
                  itemBuilder: (BuildContext context, int index) {
                    return ReasonListItem(reason: reasons[index], index: index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
