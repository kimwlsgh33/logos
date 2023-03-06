const tableReason = 'reason';
const columnReasonId = 'id';
const columnGoalId = 'goalId';
const columnReason = 'reason';

class Reason {
  final int? id;
  final String goalId;
  final String reason;

  Reason({
    this.id = 0,
    required this.goalId,
    required this.reason,
  });

  Reason.empty()
      : id = 0,
        goalId = '',
        reason = '';

  Reason.fromMap(Map<String, dynamic> map)
      : id = map[columnReasonId],
        goalId = map[columnGoalId],
        reason = map[columnReason];

  Map<String, dynamic> toMap() => <String, dynamic>{
        columnReasonId: id,
        columnGoalId: goalId,
        columnReason: reason,
      };

  Reason copyWith({
    int? id,
    String? goalId,
    String? reason,
  }) =>
      Reason(
        id: id ?? this.id,
        goalId: goalId ?? this.goalId,
        reason: reason ?? this.reason,
      );

  // getter
  int get getId => id ?? 0;
}
