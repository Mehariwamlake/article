import 'package:article_app/features/article/domain/entities/tag.dart';
import 'package:article_app/user/domain/entities/user_data.dart';
import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final DateTime date;
  final int likesCount;
  final List<Tag> tags;
  final String photoUrl;
  final UserData author;

  const Article({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.date,
    required this.likesCount,
    required this.tags,
    required this.id,
    required this.photoUrl,
    required this.author,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        content,
        date,
        likesCount,
        tags,
        photoUrl,
        author,
      ];
}
