part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthUserSignOut extends AuthEvent {
  const AuthUserSignOut();
}

class AuthUserUpdated extends AuthEvent {
  final UserEntity? user;

  const AuthUserUpdated(this.user);
}
