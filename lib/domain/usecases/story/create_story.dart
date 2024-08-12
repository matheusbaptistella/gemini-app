import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/story/create_story_req.dart';
import 'package:gemini_app/domain/repository/story/story.dart';

import '../../../service_locator.dart';

class CreateStoryUseCase
    implements UseCase<Either<Failure, String>, CreateStoryReq> {
  @override
  Future<Either<Failure, String>> call({required CreateStoryReq params}) async {
    return sl<StoryRepository>().createStory(params);
  }
}
