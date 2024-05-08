import 'package:article_app/features/user/domain/entites/user_data.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.email,
    required super.expertise,
    required super.bio,
    required super.createdAt,
    required super.image,
    required super.imageCloudinaryPublicId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      expertise: json['expertise'],
      bio: json['bio'],
      createdAt: json['createdAt'],
      image: json['image'],
      imageCloudinaryPublicId: json['imageCloudinaryPublicId'],
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
    };
  }

  UserEntity toEntity() => UserEntity(
      id: id,
      fullName: fullName,
      email: email,
      expertise: expertise,
      bio: bio,
      createdAt: createdAt,
      image: image,
      imageCloudinaryPublicId: imageCloudinaryPublicId);
}
