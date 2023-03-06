import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:logos/src/model/entities/reason.dart';
import 'package:logos/src/presenter/blocs/providers/reason_bloc.dart';

class ReasonListItem extends StatelessWidget {
  const ReasonListItem({
    super.key,
    required this.reason,
    required this.index,
  });

  final Reason reason;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      onDismissed: (direction) {
        // logic for delete
        context.read<ReasonBloc>().add(RemoveReasonEvent(reason));
        Get.snackbar(
          '삭제 완료',
          "근거가 삭제되었습니다.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("삭제하시겠습니까?",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
            content: Text("삭제후 되돌릴 수 없습니다.",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface)),
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
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            reason.reason,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
