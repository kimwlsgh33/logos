import 'package:flutter/material.dart';

class GoalBtnBar extends StatelessWidget {
  final Function(String text) onAdd;
  final TextEditingController _controller;
  const GoalBtnBar({
    super.key,
    required TextEditingController controller,
    required this.onAdd,
  }) : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FilledButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  onAdd(_controller.text);
                  _controller.clear();
                }
              },
              child: const Icon(
                Icons.add_rounded,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
