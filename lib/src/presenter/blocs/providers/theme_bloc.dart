import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {}

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(false) {
    on<ChangeTheme>((event, emit) {
      emit(!state);
    });
  }
}
