part of 'story_cubit.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

class StoryInitial extends StoryState {}

class StoryLoading extends StoryState {}

class StoryCreated extends StoryState {
  const StoryCreated({required this.story});

  final String story;

  @override
  List<Object> get props => [story];
}

class StoryParsed extends StoryState {
  const StoryParsed({required this.story});

  final Story story;

  @override
  List<Object> get props => [story];
}

class StoryError extends StoryState {
  const StoryError({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
