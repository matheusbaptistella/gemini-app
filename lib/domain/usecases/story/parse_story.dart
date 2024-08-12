import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/story/parse_story_req.dart';
import 'package:gemini_app/data/models/story/story.dart';
import 'package:gemini_app/domain/repository/story/story.dart';

import '../../../service_locator.dart';

class ParseStoryUseCase
    implements UseCase<Either<Failure, Story>, ParseStoryReq> {
  @override
  Future<Either<Failure, Story>> call({required ParseStoryReq params}) async {
    return sl<StoryRepository>().parseStory(params);
  }
}
