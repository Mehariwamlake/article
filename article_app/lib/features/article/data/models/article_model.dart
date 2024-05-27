import 'package:article_app/features/article/data/models/tag_model.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import 'package:article_app/features/article/domain/entities/tag.dart';
import 'package:article_app/user/data/models/user_data_model.dart';
import 'package:article_app/user/domain/entities/user_data.dart';

class ArticleModel extends Article {
  ArticleModel(
      {required String id,
      required String title,
      required String subtitle,
      required String content,
      required DateTime date,
      required int likesCount,
      required List<Tag> tags,
      required String photoUrl,
      required UserData author,
      required})
      : super(
          id: id,
          title: title,
          subtitle: subtitle,
          content: content,
          date: date,
          likesCount: likesCount,
          tags: tags,
          photoUrl: photoUrl,
          author: author,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final tags =
        json['tags'].map<TagModel>((name) => TagModel(name: name)).toList();
    UserDataModel author;
    try {
      author = UserDataModel(
          id: json['user']['id'],
          fullName: json['user']['fullName'] ?? 'Tamirat Dereje',
          email: json['user']['email'] ?? 'tamiratdereje@gmail.com',
          expertise: json['user']['expertise'] ?? 'Designer',
          bio: json['user']['bio'] ?? 'A short bio',
          createdAt: json['user']['createdAt'] ?? '2023-08-20T20:14:00.295Z',
          image: json['user']['image'] ?? '',
          imageCloudinaryPublicId:
              json['user']['imageCloudinaryPublicId'] ?? '',
          articles: const []);
    } catch (e) {
      author = UserDataModel(
          id: json['user'],
          fullName: 'Tamirat Dereje',
          email: 'tamiratdereje@gmail.com',
          expertise: 'Designer',
          bio: 'A short bio',
          createdAt: '2023-08-20T20:14:00.295Z',
          image:
              'https://res.cloudinary.com/dzpmgwb8t/image/upload/v1692562440/p2gekduc9q7ce139u1oe.png',
          imageCloudinaryPublicId: 'p2gekduc9q7ce139u1oe',
          articles: const []);
    }

    return ArticleModel(
      id: json['id'] ?? "id",
      title: json['title'] ?? "title",
      subtitle: json['subtitle'] ?? "subtitle",
      content: json['content'] ?? "content",
      date: DateTime.parse(json['date'] ?? "2023-08-20T20:14:00.295Z"),
      likesCount: json['likesCount'] ?? 0,
      tags: tags,
      photoUrl: json['image'] ??
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwiener.me%2F%3Fe%3D21-stock-photo-sites-that-offer-free-images-for-ww-qb9Q7KcQ&psig=AOvVaw1eR4S7FPOCBA5gjshI2Qkf&ust=1716468484637000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCLjRrsSloYYDFQAAAAAdAAAAABAT',
      author: author,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'date': date.toIso8601String(),
      'likesCount': likesCount,
      'tags': tags.map((tag) => tag.name).toList(),
      'image': photoUrl,
      'user': (author as UserDataModel).toJson(),
    };
  }
}
