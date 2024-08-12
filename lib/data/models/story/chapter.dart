class Chapter {
  final String chapterTitle;
  final String content;

  Chapter({required this.chapterTitle, required this.content});

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      chapterTitle: json['chapter_title'],
      content: json['content'],
    );
  }
}
