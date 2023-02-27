import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

abstract class ThemeEvent {}

class ChangeTheme extends ThemeEvent {}

class ThemeBloc extends Bloc<ThemeEvent, bool> {
  ThemeBloc() : super(false) {
    on<ChangeTheme>((event, emit) {
      Get.changeThemeMode(state ? ThemeMode.light : ThemeMode.dark);
      emit(!state);
    });
  }
}
