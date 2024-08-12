import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/data/models/story/create_story_req.dart';
import 'package:gemini_app/data/models/story/parse_story_req.dart';
import 'package:gemini_app/data/models/story/story.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

abstract class StoryGeminiService {
  Future<String> createStory(CreateStoryReq req);
  Story parseStory(ParseStoryReq req);
}

class StoryGeminiServiceImpl implements StoryGeminiService {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: dotenv.env['API_KEY']!,
    safetySettings: [
      SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.sexuallyExplicit, HarmBlockThreshold.high),
    ],
    generationConfig: GenerationConfig(
      temperature: 1,
      topK: 64,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'application/json',
    ),
    systemInstruction: Content.system(
        'You are a lovely parent going to tell a bed time story for your children. You know they like sweet stories with a happy ending. You want to tell a story that uses words that are comprehensible to a child, especially for the names of the characters. Your story should be slow paced, so that you can tell it during at most 10 minutes and at least 5 minutes. It should start, develop and finish. Your story should be something that the children will imagine and fall asleep doing so. And most important, only include content that is recommended for an audience of any age.'),
  );

  @override
  Future<String> createStory(CreateStoryReq req) async {
    try {
      final chat = model.startChat(history: []);
      final message = """
        Tell me a bedtime story about ${req.words}. Create a title for the story and
        organize it using chapters (the chapters also need titles)\n
        Reply to me using this JSON schema:\n\n
        {
          "title": \$storyTitle,
          "chapters": [
            {
              "chapter_title": \$chapterTitle,
              "content: \$content
            }
          ]
        }
        title, chapter_title, and content should be of type String.
        """;
      final content = Content.text(message);
      final response = await chat.sendMessage(content);
      if (response.text == null) {
        throw CreateStoryException(message: 'No text created.');
      }
      return response.text!;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Story parseStory(ParseStoryReq req) {
    try {
      final jsonData = jsonDecode(req.story);
      return Story.fromJson(jsonData);
    } catch (e) {
      rethrow;
    }
  }
}
