part of 'theme_bloc.dart';

sealed class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeUpdated extends ThemeEvent {
  final Brightness brightness;

  const ThemeUpdated(this.brightness);
}
