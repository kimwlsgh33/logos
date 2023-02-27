import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
//==============================================================================
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/config/routes/getx_routes.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/presenter/blocs/providers/goal_bloc.dart';
import 'package:logos/src/presenter/views/goals/components/anwser_card.dart';
import 'package:logos/src/presenter/views/widgets/goal_btn_bar.dart';
import 'package:logos/src/presenter/views/widgets/list_item.dart';
import 'package:logos/src/presenter/views/widgets/typing_card.dart';
import 'package:logos/src/presenter/views/widgets/full_row_textfield.dart';

class GoalDetailScreen extends StatefulWidget {
  final Goal goal;

  const GoalDetailScreen({
    super.key,
    required this.goal,
  });

  @override
  State<GoalDetailScreen> createState() => _GoalDetailScreenState();
}

class _GoalDetailScreenState extends State<GoalDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onAdd(String value) =>
        context.read<GoalBloc>().add(AddGoal(value, parentId: widget.goal.id));

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const TypingCard(text: '어떻게?'),
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.backspace_rounded),
              onPressed: () => Get.offAllNamed(GetRouter.home),
              tooltip: '목표 목록으로 돌아가기',
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Hero(
                    tag: widget.goal.id,
                    child: BlocSelector<GoalBloc, List<Goal>, Goal>(
                        selector: (state) => state.firstWhere(
                              (goal) => goal.id == widget.goal.id,
                              orElse: () => Goal.empty(),
                            ),
                        builder: (context, state) {
                          return AnswerCard(goal: state, isDetail: true);
                        }),
                  ),
                  smallVerticalSpace(),
                  FullRowTextField(
                    controller: _controller,
                    hintText: '계획을 입력해주세요',
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
            mediumVerticalSpace(),
            BlocBuilder<GoalBloc, List<Goal>>(builder: goalListBuilder)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget goalListBuilder(BuildContext context, List<Goal> goals) {
    var children = goals.where((e) => e.parentId == widget.goal.id).toList();
    children.sort((a, b) => a.priority.compareTo(b.priority));

    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: children.length,
        itemBuilder: (context, index) =>
            ListItem(goal: children[index], index: index),
        separatorBuilder: (context, index) => smallVerticalSpace(),
      ),
    );
  }
}
