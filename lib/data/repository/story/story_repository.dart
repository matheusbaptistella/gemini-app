import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/story/create_story_req.dart';
import 'package:gemini_app/data/models/story/parse_story_req.dart';
import 'package:gemini_app/data/models/story/story.dart';
import 'package:gemini_app/data/sources/story/story_gemini_service.dart';
import 'package:gemini_app/domain/repository/story/story.dart';

import '../../../service_locator.dart';

class StoryRepostitoryImpl implements StoryRepository {
  @override
  Future<Either<Failure, String>> createStory(CreateStoryReq req) async {
    try {
      return Right(await sl<StoryGeminiService>().createStory(req));
    } on CreateStoryException catch (e) {
      return Left(CreateStoryFailure(message: e.message));
    } catch (_) {
      return const Left(CreateStoryFailure());
    }
  }

  @override
  Either<Failure, Story> parseStory(ParseStoryReq req) {
    try {
      return Right(sl<StoryGeminiService>().parseStory(req));
    } catch (e) {
      return const Left(ParseStoryFailure());
    }
  }
}
