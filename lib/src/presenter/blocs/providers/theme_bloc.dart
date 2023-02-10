import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final bool isDark;

  ThemeChanged({required this.isDark});
}

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(false);
}
