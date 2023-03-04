import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/src/base/utils.dart';
import 'package:logos/src/model/entities/goal.dart';
import 'package:logos/src/model/repositories/goal_repository.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> debounceTime<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

//============================================================
// Bloc 객체
//============================================================
class GoalBloc extends Bloc<GoalEvent, GoalState> {
  final GoalRepository _goalRepository;
  GoalBloc(this._goalRepository) : super(InitGoalState()) {
    on<GoalEvent>(_onGoalEvent, transformer: sequential());
    on<AddGoalEvent>(_addGoal);
    on<RemoveGoalEvent>(_removeGoal);
    on<CompleteGoalEvent>(_completeGoal);
    on<EditGoalEvent>(_editGoal);
    on<CancelGoalCompleteEvent>(_cancelGoalComplete);
    add(LoadRootGoalEvent());
    add(LoadCompleteGoalEvent());
  }

  _onGoalEvent(GoalEvent event, Emitter<GoalState> emit) async {
    if (event is LoadRootGoalEvent) {
      await _loadRootGoal(event, emit);
    } else if (event is LoadCompleteGoalEvent) {
      await _loadCompleteGoal(event, emit);
    }
  }

  //================================================================
  // Bloc Initializer
  //================================================================
  _loadRootGoal(LoadRootGoalEvent event, Emitter<GoalState> emit) async {
    emit(LoadingGoalState(
      rootGoals: state.rootGoals,
      completeGoals: state.completeGoals,
    ));
    try {
      final roots = await _goalRepository.getYet();
      emit(LoadedGoalState(
        rootGoals: roots,
        completeGoals: state.completeGoals,
      ));
    } catch (e) {
      emit(ErrorGoalState(e.toString()));
    }
  }

  _loadCompleteGoal(
      LoadCompleteGoalEvent event, Emitter<GoalState> emit) async {
    emit(LoadingGoalState(
      rootGoals: state.rootGoals,
      completeGoals: state.completeGoals,
    ));

    try {
      final completed = await _goalRepository.getCompleted();
      emit(LoadedGoalState(
        rootGoals: state.rootGoals,
        completeGoals: completed,
      ));
    } catch (e) {
      emit(ErrorGoalState(e.toString()));
    }
  }

  //================================================================
  // Bloc에 전달된 Event를 처리하는 함수
  //================================================================
  void _addGoal(AddGoalEvent event, Emitter<GoalState> emit) {
    emit(LoadingGoalState(
      rootGoals: state.rootGoals,
      completeGoals: state.completeGoals,
    ));
    // 만약에, 완료한 목표를 복구한다면, UI만 변경
    if (event.goal == null) {
      var goal = Goal(
        id: makeUUID(),
        parentId: event.parentId,
        content: event.text,
        goalDate: DateTime.now(),
      );
      _goalRepository.insert(goal);
      emit(LoadedGoalState(
        rootGoals: [...state.rootGoals!, goal],
        completeGoals: state.completeGoals,
      ));
    } else {
      emit(LoadedGoalState(
        rootGoals: [...state.rootGoals!, event.goal!],
        completeGoals: state.completeGoals,
      ));
    }
  }

  void _editGoal(EditGoalEvent event, Emitter<GoalState> emit) {
    emit(LoadingGoalState(
      rootGoals: state.rootGoals,
      completeGoals: state.completeGoals,
    ));
    // type mismatch => not update ui
    _goalRepository.update(event.goal);

    final goals = state.rootGoals!.map((prev) {
      if (prev.id == event.goal.id) {
        return event.goal;
      } else {
        return prev;
      }
    }).toList();

    goals.sort((a, b) => a.goalDate.compareTo(b.goalDate));
    emit(LoadedGoalState(
      rootGoals: goals,
      completeGoals: state.completeGoals,
    ));
  }

  void _completeGoal(CompleteGoalEvent event, Emitter<GoalState> emit) async {
    emit(LoadingGoalState(
      rootGoals: state.rootGoals,
      completeGoals: state.completeGoals,
    ));
    // value copy
    final goal = event.goal.copyWith(done: true);
    final nextRoots =
        state.rootGoals!.where((element) => element != event.goal).toList();
    _goalRepository.update(goal);

    // root -> complete
    emit(LoadedGoalState(
      rootGoals: nextRoots,
      completeGoals: [...state.completeGoals!, goal],
    ));
  }

  void _cancelGoalComplete(
      CancelGoalCompleteEvent event, Emitter<GoalState> emit) {
    emit(LoadingGoalState(
      rootGoals: state.rootGoals,
      completeGoals: state.completeGoals,
    ));
    // value copy
    final goal = event.goal.copyWith(done: false);
    final nextComplete =
        state.completeGoals!.where((element) => element != event.goal).toList();
    _goalRepository.update(goal);
    // complete -> root
    emit(LoadedGoalState(
      rootGoals: [...state.rootGoals!, goal],
      completeGoals: nextComplete,
    ));
  }

  void _removeGoal(RemoveGoalEvent event, Emitter<GoalState> emit) async {
    emit(LoadingGoalState(
      rootGoals: state.rootGoals,
      completeGoals: state.completeGoals,
    ));
    _goalRepository.remove(event.goal);
    if (event.goal.done) {
      final next = state.completeGoals!
          .where((element) => element != event.goal)
          .toList();
      emit(LoadedGoalState(
        rootGoals: state.rootGoals,
        completeGoals: next,
      ));
    } else {
      final next =
          state.rootGoals!.where((element) => element != event.goal).toList();
      emit(LoadedGoalState(
        rootGoals: next,
        completeGoals: state.completeGoals,
      ));
    }
  }
}

//==============================================================================
// Event 객체를 만들어서 Bloc에 전달
//==============================================================================
abstract class GoalEvent extends Equatable {}

class LoadRootGoalEvent extends GoalEvent {
  @override
  List<Object> get props => [];
}

class LoadCompleteGoalEvent extends GoalEvent {
  @override
  List<Object> get props => [];
}

// Create
class AddGoalEvent extends GoalEvent {
  final String text;
  final String parentId;
  final Goal? goal;

  AddGoalEvent(
    this.text, {
    this.goal,
    this.parentId = 'root',
  });

  @override
  List<Object?> get props => [];
}

// Update
class EditGoalEvent extends GoalEvent {
  final Goal goal;
  EditGoalEvent(this.goal);
  @override
  List<Object?> get props => [];
}

class CompleteGoalEvent extends GoalEvent {
  final Goal goal;
  CompleteGoalEvent(this.goal);
  @override
  List<Object?> get props => [];
}

class CancelGoalCompleteEvent extends GoalEvent {
  final Goal goal;
  CancelGoalCompleteEvent(this.goal);
  @override
  List<Object?> get props => [];
}

// Delete
class RemoveGoalEvent extends GoalEvent {
  final Goal goal;
  RemoveGoalEvent(this.goal);
  @override
  List<Object?> get props => [];
}

class ClearGoalEvent extends GoalEvent {
  final BuildContext context;
  ClearGoalEvent(this.context);
  @override
  List<Object?> get props => [];
}

//============================================================
// Bloc State
//============================================================
abstract class GoalState extends Equatable {
  final List<Goal>? rootGoals;
  final List<Goal>? completeGoals;
  const GoalState({
    this.rootGoals,
    this.completeGoals,
  });
}

class InitGoalState extends GoalState {
  InitGoalState() : super(rootGoals: <Goal>[], completeGoals: <Goal>[]);
  @override
  List<Object?> get props => [rootGoals, completeGoals];
}

class LoadingGoalState extends GoalState {
  const LoadingGoalState({
    super.rootGoals,
    super.completeGoals,
  });
  @override
  List<Object?> get props => [rootGoals, completeGoals];
}

class LoadedGoalState extends GoalState {
  const LoadedGoalState({
    super.rootGoals,
    super.completeGoals,
  });
  @override
  List<Object?> get props => [rootGoals, completeGoals];
}

class ErrorGoalState extends GoalState {
  final String message;
  const ErrorGoalState(this.message);
  @override
  List<Object?> get props => [message];
}
