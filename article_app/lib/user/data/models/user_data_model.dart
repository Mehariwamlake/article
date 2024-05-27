import 'package:article_app/features/article/data/models/article_model.dart';
import 'package:article_app/features/article/domain/entities/article.dart';
import '../../domain/entities/user_data.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required String id,
    required String fullName,
    required String email,
    required String expertise,
    required String bio,
    required String createdAt,
    required String image,
    required String imageCloudinaryPublicId,
    required List<Article> articles,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
          expertise: expertise,
          bio: bio,
          createdAt: createdAt,
          image: image,
          imageCloudinaryPublicId: imageCloudinaryPublicId,
          articles: articles,
        );

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      expertise: json['expertise'],
      bio: json['bio'],
      createdAt: json['createdAt'],
      image: json['image'] ?? '',
      imageCloudinaryPublicId: json['imageCloudinaryPublicId'] ?? '',
      articles: json['articles'] == null
          ? const []
          : (json['articles'] as List)
              .map<ArticleModel>((m) => ArticleModel.fromJson(m))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'expertise': expertise,
      'bio': bio,
      'createdAt': createdAt,
      'image': image,
      'imageCloudinaryPublicId': imageCloudinaryPublicId,
      'articles': articles.map((e) => (e as ArticleModel).toJson()).toList(),
    };
  }
}
