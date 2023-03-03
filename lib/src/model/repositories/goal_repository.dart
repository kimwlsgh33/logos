import 'package:logos/src/data/sources/local/goal_provider.dart';
import 'package:logos/src/model/entities/goal.dart';

class GoalRepository {
  final GoalProvider _goalProvider = GoalProvider();

  Future<void> deleteDatabase() async {
    await _goalProvider.deleteDatabase();
  }

  Future<List<Goal>> getAll() async {
    return await _goalProvider.getAll();
  }

  Future<List<Goal>> getYet() async {
    return await _goalProvider.getYet();
  }

   Future<List<Goal>> getCompleted({bool not = false}) async {
    return await _goalProvider.getCompleted(not);
  }

   Future<Goal> getGoal(Goal goal) async {
    return await _goalProvider.getGoal(goal);
  }

   Future<void> insert(Goal goal) async {
    await _goalProvider.insert(goal);
  }

   Future<void> update(Goal goal) async {
    await _goalProvider.update(goal);
  }

   Future<void> remove(Goal goal) async {
    await _goalProvider.remove(goal);
  }

   Future<void> removeAll() async {
    await _goalProvider.removeAll();
  }
}
