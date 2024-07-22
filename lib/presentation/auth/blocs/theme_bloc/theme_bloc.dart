import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeInitial()) {
    on<ThemeUpdated>((event, emit) {
      final themeMode = event.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      emit(ThemeState(themeMode: themeMode));
    });
  }
}
