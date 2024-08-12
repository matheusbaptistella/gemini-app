import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/story/create_story_req.dart';
import 'package:gemini_app/data/models/story/parse_story_req.dart';
import 'package:gemini_app/data/models/story/story.dart';

abstract class StoryRepository {
  Future<Either<Failure, String>> createStory(CreateStoryReq req);
  Either<Failure, Story> parseStory(ParseStoryReq req);
}
