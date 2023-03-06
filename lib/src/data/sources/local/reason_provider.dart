import 'package:logos/src/data/sources/local/goal_database.dart';
import '../../../model/entities/reason.dart';

class ReasonProvider {
  final GoalDatabase _goalDatabase = GoalDatabase.instance;

  Future<void> insert(Reason reason) async {
    final db = await _goalDatabase.database;
    await db.insert('reason', reason.toMap());
  }

  Future<Reason> getReason(Reason reason) async {
    final db = await _goalDatabase.database;
    final List<Map<String, dynamic>> maps = await db
        .query('reason', where: '$columnReasonId = ?', whereArgs: [reason.getId]);
    return Reason(
      id: maps[0][columnGoalId],
      goalId: maps[0][columnGoalId],
      reason: maps[0][columnReason],
    );
  }

  Future<void> update(Reason reason) async {
    final db = await _goalDatabase.database;
    await db.update(
      'reason',
      reason.toMap(),
      where: '$columnReasonId = ?',
      whereArgs: [reason.getId],
    );
  }

  Future<void> remove(Reason reason) async {
    final db = await _goalDatabase.database;
    await db.delete(
      'reason',
      where: '$columnReasonId = ?',
      whereArgs: [reason.getId],
    );
  }

  Future<void> removeAll() async {
    final db = await _goalDatabase.database;
    await db.delete('reason');
  }

  Future<List<Reason>> getAll() async {
    final db = await _goalDatabase.database;
    final List<Map<String, dynamic>> maps = await db.query('reason');

    return List.generate(maps.length, (i) {
      return Reason(
        id: maps[i][columnReasonId],
        goalId: maps[i][columnGoalId],
        reason: maps[i][columnReason],
      );
    });
  }

  Future<List<Reason>> getByGoalId(String goalId) async {
    final db = await _goalDatabase.database;
    final List<Map<String, dynamic>> maps = await db
        .query('reason', where: '$columnGoalId = ?', whereArgs: [goalId]);

    return List.generate(maps.length, (i) {
      return Reason(
        id: maps[i][columnReasonId],
        goalId: maps[i][columnGoalId],
        reason: maps[i][columnReason],
      );
    });
  }
}
