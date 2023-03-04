import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/presenter/blocs/providers/goal_bloc.dart';
import 'package:logos/src/presenter/blocs/providers/theme_bloc.dart';
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
    void onAdd(value) => context.read<GoalBloc>().add(AddGoalEvent(value));

    SystemChrome.setSystemUIOverlayStyle(context.read<ThemeBloc>().state
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const TypingCard(
                      text: '최종 목표를 작성하세요!',
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
              BlocSelector<GoalBloc, GoalState, List<Goal>>(
                selector: (state) => state.rootGoals!,
                builder: goalListBuilder
              ),
            ],
          ),
        ),
        floatingActionButton:
            BlocBuilder<ThemeBloc, bool>(builder: (context, isDark) {
          return FloatingActionButton(
            onPressed: () => context.read<ThemeBloc>().add(ToggleTheme()),
            child: isDark
                ? const Icon(Icons.light_mode_rounded)
                : const Icon(Icons.dark_mode_rounded),
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
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
