const tableGoal = 'goal';
const columnId = 'id';
const columnParentId = 'parentId';
const columnContent = 'content';
const columnGoalDate = 'goal_date';
const columnPriority = 'priority';
const columnDone = 'done';

class Goal {
  String id; // 목표를 구분하기 위한 id
  String parentId;
  String content; // 목표 내용
  DateTime goalDate; // 목표 완료 날짜
  int priority; // 목표 우선순위
  bool done; // 목표 완료 여부

  Goal({
    required this.id,
    this.parentId = 'root',
    required this.content,
    required this.goalDate,
    this.priority = 99,
    this.done = false,
  });

  Goal.empty()
      : id = '',
        parentId = '',
        content = '',
        goalDate = DateTime.now(),
        priority = 99,
        done = false;

  Goal.fromMap(Map<String, dynamic> map)
      : id = map[columnId],
        parentId = map[columnParentId],
        content = map[columnContent],
        goalDate = DateTime.fromMillisecondsSinceEpoch(map[columnGoalDate]),
        priority = map[columnPriority],
        done = map[columnDone] == 1;

  Map<String, dynamic> toMap() => <String, dynamic>{
        columnId: id,
        columnContent: content,
        columnGoalDate: goalDate.microsecondsSinceEpoch, // convert to int
        columnPriority: priority,
        columnDone: done ? 1 : 0,
        columnParentId: parentId,
      };

  Goal copyWith({
    String? id,
    String? parentId,
    String? content,
    DateTime? goalDate,
    int? priority,
    bool? done,
  }) =>
      Goal(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        content: content ?? this.content,
        goalDate: goalDate ?? this.goalDate,
        priority: priority ?? this.priority,
        done: done ?? this.done,
      );

  // getter
  String get getId => id;
}
