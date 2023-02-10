import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/model/repositories/goal_repository.dart';
import 'package:rxdart/rxdart.dart';

abstract class GoalEvent {}

//==============================================================================
// Event 객체를 만들어서 Bloc에 전달
//==============================================================================
class InitGoal extends GoalEvent {}

class AddGoal extends GoalEvent {
  final String text;
  final String parentId;
  AddGoal(
    this.text, {
    this.parentId = 'root',
  });
}

class RemoveGoal extends GoalEvent {
  final Goal goal;
  RemoveGoal(this.goal);
}

class EditGoal extends GoalEvent {
  final Goal goal;
  EditGoal(this.goal);
}

class CompleteGoal extends GoalEvent {
  final Goal goal;
  CompleteGoal(this.goal);
}

//============================================================
//
//============================================================
class ClearGoal extends GoalEvent {
  final BuildContext context;
  ClearGoal(this.context);
}

class DeleteDatabase extends GoalEvent {}

EventTransformer<T> debounceTime<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

//============================================================
// Bloc State
//============================================================
class GoalState {}

//============================================================
// Bloc 객체
//============================================================
class GoalBloc extends Bloc<GoalEvent, List<Goal>> {
  late List<Goal> _goals;
  get goals => _goals;

  GoalBloc() : super(<Goal>[]) {
    on<InitGoal>(_onInitGoal);
    on<AddGoal>(
      _addGoal,
      transformer: droppable(),
    );
    on<RemoveGoal>(_removeGoal);
    on<CompleteGoal>(_completeGoal);
    on<EditGoal>(_editGoal);
    //========================================================
    // dev
    //========================================================
    on<ClearGoal>(
      _clearGoal,
      transformer: debounceTime<ClearGoal>(const Duration(milliseconds: 1000)),
    );
    on<DeleteDatabase>((event, emit) {
      GoalRepository.deleteDatabase();
    });
  }
  //================================================================
  // Bloc에 전달된 Event를 처리하는 함수
  //================================================================
  void _onInitGoal(InitGoal event, Emitter<List<Goal>> emit) async {
    if (state.isEmpty) {
      // emit(await GoalRepository.getCompleted(true));
      emit(await GoalRepository.getAll());
    }
  }

  void _addGoal(AddGoal event, Emitter<List<Goal>> emit) {
    var goal = Goal(
      id: makeUUID(),
      parentId: event.parentId,
      content: event.text,
      goalDate: DateTime.now(),
    );
    GoalRepository.insert(goal);
    emit([goal, ...state]);
  }

  void _removeGoal(RemoveGoal event, Emitter<List<Goal>> emit) {
    GoalRepository.remove(event.goal);
    emit(state.where((element) => element != event.goal).toList());
  }

  void _completeGoal(CompleteGoal event, Emitter<List<Goal>> emit) {
    var goal = event.goal.copyWith(done: true);
    GoalRepository.update(goal);
  }

  void _editGoal(EditGoal event, Emitter<List<Goal>> emit) {
    // type mismatch => not update ui
    GoalRepository.update(event.goal);
    _goals = state.map((e) {
      if (e.id == event.goal.id) {
        return event.goal;
      } else {
        return e;
      }
    }).toList();
    _goals.sort((a, b) => a.goalDate.compareTo(b.goalDate));
    emit([..._goals]);
  }

  //================================================================
  // dev
  //================================================================
  void _clearGoal(ClearGoal event, Emitter<List<Goal>> emit) {
    showDialog(
      context: event.context,
      builder: (context) => AlertDialog(
        title: const Text('Clear all goals?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              GoalRepository.removeAll().whenComplete(() {
                Navigator.pop(context);
                InitGoal();
              });
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
