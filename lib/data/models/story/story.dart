import 'package:gemini_app/data/models/story/chapter.dart';

class Story {
  final String title;
  final List<Chapter> chapters;

  Story({required this.title, required this.chapters});

  factory Story.fromJson(Map<String, dynamic> json) {
    var chaptersList = (json['chapters'] as List)
        .map((chapterJson) => Chapter.fromJson(chapterJson))
        .toList();

    return Story(
      title: json['title'],
      chapters: chaptersList,
    );
  }
}
