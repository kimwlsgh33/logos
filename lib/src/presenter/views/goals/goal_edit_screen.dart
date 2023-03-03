import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/presenter/blocs/providers/goal_bloc.dart';
import 'package:logos/src/presenter/views/widgets/typing_card.dart';

class GoalEditScreen extends StatefulWidget {
  const GoalEditScreen({
    super.key,
    required this.goal,
  });

  final Goal goal;

  @override
  State<GoalEditScreen> createState() => _GoalEditScreenState();
}

class _GoalEditScreenState extends State<GoalEditScreen> {
  late TextEditingController _textController;
  late TextEditingController _priorityController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.goal.content);
    _priorityController =
        TextEditingController(text: widget.goal.priority.toString());
  }

  @override
  void dispose() {
    _textController.dispose();
    _priorityController.dispose();
    super.dispose();
  }

  void _onSubmitted() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('목표 수정', style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        content: Text('수정하시겠습니까?',style: TextStyle(color: Theme.of(context).colorScheme.onSurface)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('취소'),
          ),
          BlocSelector<GoalBloc, GoalState, Goal>(
              selector: (state) =>
                  state.rootGoals!.firstWhere((element) => element.id == widget.goal.id),
              builder: (context, goal) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<GoalBloc>().add(EditGoalEvent(goal.copyWith(
                          content: _textController.text,
                          priority: int.parse(_priorityController.text),
                        )));
                    Get.back();
                    Get.back();
                    Get.snackbar(
                      '수정 완료',
                      '수정이 완료되었습니다',
                      snackPosition: SnackPosition.TOP,
                      backgroundColor: Colors.green,
                      colorText: Colors.white,
                      duration: const Duration(seconds: 2),
                    );
                  },
                  child: const Text('확인'),
                );
              }),
        ],
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const TypingCard(
            text: "목표를 수정해보세요",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  widget.goal.content,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                smallVerticalSpace(),
                Text(
                  widget.goal.priority.toString(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                smallVerticalSpace(),
                TextFormField(
                  controller: _textController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '목표를 입력해주세요';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '목표',
                  ),
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
                mediumVerticalSpace(),
                TextFormField(
                  controller: _priorityController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '우선순위를 입력해주세요';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '우선순위',
                  ),
                  keyboardType: TextInputType.number,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.goal.content != _textController.text ||
                  widget.goal.priority != int.parse(_priorityController.text)) {
                _onSubmitted();
              } else {
                Get.back();
              }
            }
          },
          child: const Icon(Icons.check),
        ),
      ),
    );
  }
}
