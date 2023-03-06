import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logos/src/model/entities/reason.dart';
import 'package:logos/src/model/repositories/reason_repository.dart';

class ReasonBloc extends Bloc<ReasonEvent, ReasonState> {
  final ReasonRepository _reasonRepository;
  ReasonBloc(this._reasonRepository) : super(InitReasonState()) {
    on<LoadReasonEvent>(_loadAllReasons);
    on<AddReasonEvent>(_addReason);
    on<RemoveReasonEvent>(_removeReason);
    add(LoadReasonEvent());
  }

//================================================================
// Bloc Initializer
//================================================================
  _loadAllReasons(LoadReasonEvent event, Emitter<ReasonState> emit) async {
    emit(const LoadingReasonState());
    final result = await _reasonRepository.getAll();
    emit(LoadedReasonState(reasons: result));
  }

  //================================================================
  // Bloc
  //================================================================
  _addReason(AddReasonEvent event, Emitter<ReasonState> emit) async {
    var reason = Reason(
      goalId: event.goalId,
      reason: event.reason,
    );
    await _reasonRepository.insert(reason);
    add(LoadReasonEvent());
  }

  _removeReason(RemoveReasonEvent event, Emitter<ReasonState> emit) async {
    await _reasonRepository.remove(event.reason);
    add(LoadReasonEvent());
  }

  //================================================================
  // Observer
  //================================================================
  @override
  void onChange(Change<ReasonState> change) {
    super.onChange(change);
  }
}

//==============================================================================
// Event 객체를 만들어서 Bloc에 전달
//==============================================================================
abstract class ReasonEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadReasonEvent extends ReasonEvent {}

class AddReasonEvent extends ReasonEvent {
  final String reason;
  final String goalId;
  AddReasonEvent(
    this.reason, {
    required this.goalId,
  });
}

class RemoveReasonEvent extends ReasonEvent {
  final Reason reason;
  RemoveReasonEvent(this.reason);
}

//============================================================
// Bloc State
//============================================================
abstract class ReasonState extends Equatable {
  final List<Reason>? reasons;
  const ReasonState({this.reasons});
}

class InitReasonState extends ReasonState {
  InitReasonState() : super(reasons: <Reason>[]);
  @override
  List<Object> get props => [];
}

class LoadingReasonState extends ReasonState {
  const LoadingReasonState({super.reasons});
  @override
  List<Object?> get props => [reasons];
}

class LoadedReasonState extends ReasonState {
  const LoadedReasonState({super.reasons});
  @override
  List<Object?> get props => [reasons];
}

class ErrorReasonState extends ReasonState {
  final String message;
  const ErrorReasonState(this.message);
  @override
  List<Object?> get props => [message];
}
