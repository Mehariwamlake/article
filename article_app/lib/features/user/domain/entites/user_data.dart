import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String fullName;
  final String email;
  final String expertise;
  final String bio;
  final String createdAt;
  final String image;
  final String imageCloudinaryPublicId;

  const UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    required this.expertise,
    required this.bio,
    required this.createdAt,
    required this.image,
    required this.imageCloudinaryPublicId,
  });

 

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        fullName,
        email,
        expertise,
        bio,
        createdAt,
        image,
        imageCloudinaryPublicId,
      ];
}
