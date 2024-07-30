import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.email,
    required this.name,
    required this.profilePictureUrl,
  });

  final String email;
  final String name;
  final String profilePictureUrl;

  @override
  String toString() {
    return 'UserEntity:$email, $name';
  }

  @override
  List<Object?> get props => [email, name, profilePictureUrl];
}
