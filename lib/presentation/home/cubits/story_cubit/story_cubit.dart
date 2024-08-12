import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/story/create_story_req.dart';
import 'package:gemini_app/data/models/story/parse_story_req.dart';
import 'package:gemini_app/data/models/story/story.dart';
import 'package:gemini_app/domain/usecases/story/create_story.dart';
import 'package:gemini_app/domain/usecases/story/parse_story.dart';

import '../../../../service_locator.dart';

part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryInitial());

  Future<void> createStory(String words) async {
    emit(StoryLoading());
    final Either<Failure, String> storyResult = await sl<CreateStoryUseCase>()
        .call(params: CreateStoryReq(words: words));
    storyResult
        .fold((failure) => emit(StoryError(errorMessage: failure.message)),
            (story) async {
      emit(StoryCreated(story: story));
      final Either<Failure, Story> parseResult = await sl<ParseStoryUseCase>()
          .call(params: ParseStoryReq(story: story));
      parseResult.fold(
        (failure) => emit(StoryError(errorMessage: failure.message)),
        (parsedStory) => emit(StoryParsed(story: parsedStory)),
      );
    });
  }
}
