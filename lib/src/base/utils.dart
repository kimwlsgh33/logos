import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

// 알림을 보내는 기능 ( 자주 사용하므로 따로 빼놓음 )
showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

String makeUUID() => const Uuid().v4();

double randomValue() =>
    (100 * (1 + (Random().nextDouble() * 100))).roundToDouble();

Widget smallVerticalSpace() => const SizedBox(height: 8);
Widget smallHorizontalSpace() => const SizedBox(width: 8);

Widget mediumVerticalSpace() => const SizedBox(height: 16);
Widget mediumHorizontalSpace() => const SizedBox(width: 16);
Widget noGoalWidget() => const SizedBox(
      height: 100,
      child: Text("목표가 없습니다."),
    );
