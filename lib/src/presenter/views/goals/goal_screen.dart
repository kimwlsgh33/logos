import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/model/repositories/goal_repository.dart';
import 'package:logos/src/presenter/blocs/providers/goal_bloc.dart';
import 'package:logos/src/presenter/views/widgets/full_row_textfield.dart';
import 'package:logos/src/presenter/views/widgets/goal_btn_bar.dart';
import 'package:logos/src/presenter/views/widgets/list_item.dart';
import 'package:logos/src/presenter/views/widgets/typing_card.dart';

import '../../../base/utils.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // init goalBloc
    context.read<GoalBloc>().add(InitGoal());

    void onAdd(value) => context.read<GoalBloc>().add(AddGoal(value));

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const TypingCard(
                    text: '만약 어떤 목표라도 성취할수있는\n 능력을 가지고 있다면?',
                    icon: Icons.where_to_vote_rounded,
                  ),
                  smallVerticalSpace(),
                  FullRowTextField(
                    controller: _textController,
                    hintText: '원하는 것 추가하기',
                    onSubmitted: onAdd,
                  ),
                  smallVerticalSpace(),
                  Hero(
                    tag: 'goalBtnBar',
                    child: GoalBtnBar(
                      onAdd: onAdd,
                      controller: _textController,
                    ),
                  ),
                  mediumVerticalSpace()
                ],
              ),
            ),
            // const GoalList(),
            BlocBuilder<GoalBloc, List<Goal>>(builder: goalListBuilder),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoalRepository.deleteDatabase();
        },
        child: const Icon(Icons.close),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Widget goalListBuilder(BuildContext context, List<Goal> goals) {
    var roots = goals.where((element) => element.parentId == "root").toList();
    roots.sort((a, b) => a.priority.compareTo(b.priority));

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: roots.length,
        itemBuilder: (context, index) => ListItem(
          key: ValueKey(roots[index].id),
          goal: roots[index],
          index: index,
        ),
        separatorBuilder: (context, index) => smallVerticalSpace(),
      ),
    );
  }
}
