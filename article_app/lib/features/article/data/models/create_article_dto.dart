import 'dart:io';

class CreateUpdateArticleDto {
  final String title;
  final String subtitle;
  final String photoPath;
  final List<String> tags;
  final String content;

  CreateUpdateArticleDto(
      {required this.title,
      required this.subtitle,
      required this.photoPath,
      required this.tags,
      required this.content});

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'content': content,
        'photo': File(photoPath),
        'tags': tags
      };
}
