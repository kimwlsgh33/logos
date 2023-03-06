import 'package:logos/src/data/sources/local/goal_database.dart';
import '../../../model/entities/goal.dart';

class GoalProvider {
  final GoalDatabase _goalDatabase = GoalDatabase.instance;

  Future<void> insert(Goal goal) async {
    final db = await _goalDatabase.database;
    await db.insert('goal', goal.toMap());
  }

  Future<Goal> getGoal(Goal goal) async {
    final db = await _goalDatabase.database;
    final List<Map<String, dynamic>> maps =
        await db.query('goal', where: '$columnId = ?', whereArgs: [goal.getId]);
    return Goal(
      id: maps[0][columnId],
      parentId: maps[0][columnParentId],
      content: maps[0][columnContent],
      goalDate: maps[0][columnGoalDate],
      startDate: maps[0][columnStartDate],
      priority: maps[0][columnPriority],
      done: maps[0][columnDone] == 1,
    );
  }

  Future<void> update(Goal goal) async {
    final db = await _goalDatabase.database;
    await db.update(
      'goal',
      goal.toMap(),
      where: '$columnId = ?',
      whereArgs: [goal.getId],
    );
  }

  Future<void> remove(Goal goal) async {
    final db = await _goalDatabase.database;
    await db.delete(
      'goal',
      where: '$columnId = ?',
      whereArgs: [goal.getId],
    );
  }

  Future<void> removeAll() async {
    final db = await _goalDatabase.database;
    await db.delete('goal');
  }

  Future<List<Goal>> getAll() async {
    final db = await _goalDatabase.database;
    final List<Map<String, dynamic>> maps =
        await db.query('goal', orderBy: '$columnPriority ASC');

    return List.generate(maps.length, (i) {
      var goalDate = int.parse(maps[i][columnGoalDate].toString());
      var startDate = int.parse(maps[i][columnStartDate].toString());
      return Goal(
        id: maps[i][columnId],
        parentId: maps[i][columnParentId],
        content: maps[i][columnContent],
        goalDate: DateTime.fromMillisecondsSinceEpoch(goalDate),
        startDate: DateTime.fromMillisecondsSinceEpoch(startDate),
        priority: maps[i][columnPriority],
        done: maps[i][columnDone] == 1,
      );
    });
  }

  Future<List<Goal>> getYet() async {
    final db = await _goalDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('goal',
        orderBy: '$columnPriority ASC', where: '$columnDone = 0');

    return List.generate(maps.length, (i) {
      var goalDate = int.parse(maps[i][columnGoalDate].toString());
      var startDate = int.parse(maps[i][columnStartDate].toString());
      // _logger.i('goalDate: $goalDate');
      return Goal(
        id: maps[i][columnId],
        parentId: maps[i][columnParentId],
        content: maps[i][columnContent],
        goalDate: DateTime.fromMillisecondsSinceEpoch(goalDate),
        startDate: DateTime.fromMillisecondsSinceEpoch(startDate),
        priority: maps[i][columnPriority],
        done: maps[i][columnDone] == 1,
      );
    });
  }

  Future<List<Goal>> getCompleted(bool not) async {
    final db = await _goalDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'goal',
      where: '$columnDone = ?',
      whereArgs: [not ? 0 : 1],
      orderBy: '$columnPriority ASC',
    );

    return List.generate(maps.length, (i) {
      var goalDate = int.parse(maps[i][columnGoalDate].toString());
      var startDate = int.parse(maps[i][columnStartDate].toString());
      // _logger.i('goalDate: $goalDate');
      return Goal(
        id: maps[i][columnId],
        parentId: maps[i][columnParentId],
        content: maps[i][columnContent],
        goalDate: DateTime.fromMillisecondsSinceEpoch(goalDate),
        startDate: DateTime.fromMillisecondsSinceEpoch(startDate),
        priority: maps[i][columnPriority],
        done: maps[i][columnDone] == 1,
      );
    });
  }
}
