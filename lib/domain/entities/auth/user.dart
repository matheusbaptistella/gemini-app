import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.email,
    required this.name,
  });

  final String email;
  final String name;

  @override
  String toString() {
    return 'UserEntity:$email, $name';
  }

  @override
  List<Object?> get props => [email, name];
}
