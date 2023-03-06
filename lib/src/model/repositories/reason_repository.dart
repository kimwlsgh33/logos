import 'package:logos/src/data/sources/local/reason_provider.dart';
import 'package:logos/src/model/entities/reason.dart';

class ReasonRepository {
  static final ReasonProvider _reasonProvider = ReasonProvider();

  Future<List<Reason>> getAll() async {
    return await _reasonProvider.getAll();
  }

  Future<Reason> getReason(Reason reason) async {
    return await _reasonProvider.getReason(reason);
  }

  Future<void> insert(Reason reason) async {
    await _reasonProvider.insert(reason);
  }

  Future<void> update(Reason reason) async {
    await _reasonProvider.update(reason);
  }

  Future<void> remove(Reason reason) async {
    await _reasonProvider.remove(reason);
  }

  Future<void> removeAll() async {
    await _reasonProvider.removeAll();
  }

  Future<List<Reason>> getByGoalId(String goalId) async {
    return await _reasonProvider.getByGoalId(goalId);
  }
}
