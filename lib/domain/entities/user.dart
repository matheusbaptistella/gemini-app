import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.profilePictureUrl,
  });

  final String userId;
  final String email;
  final String name;
  final String profilePictureUrl;

  @override
  String toString() {
    return 'UserEntity: $userId, $email, $name, $profilePictureUrl';
  }

  @override
  List<Object?> get props => [userId, email, name, profilePictureUrl];
}
