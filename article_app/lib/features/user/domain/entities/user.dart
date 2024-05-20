import "package:article_app/features/article/domain/entities/article.dart";
import "package:equatable/equatable.dart";

class User extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String expertise;
  final String bio;
  final String createdAt;
  final String image;
  final String imageCloudinaryPublicId;
  final List<Article> articles;

  const User({
    required this.expertise,
    required this.createdAt,
    required this.image,
    required this.imageCloudinaryPublicId,
    required this.id,
    required this.fullName,
    required this.email,
    required this.bio,
    required this.articles,
  }) : super();

  static get empty => const User(
      articles: [],
      bio: '',
      createdAt: '',
      email: '',
      expertise: '',
      fullName: '',
      id: '',
      image: '',
      imageCloudinaryPublicId: '');

  @override
  List<Object?> get props => [
        id,
        fullName,
        email,
        expertise,
        bio,
        createdAt,
        image,
        imageCloudinaryPublicId,
        articles
      ];
}
