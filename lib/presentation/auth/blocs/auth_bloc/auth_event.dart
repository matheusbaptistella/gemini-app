part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserUpdated extends AuthEvent {
  final UserEntity? user;

  const AuthUserUpdated(this.user);
}
