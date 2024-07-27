part of 'auth_bloc.dart';

enum AuthStatus { authenticated, unauthenticated, unknown }

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user,
  });

  final AuthStatus status;
  final UserEntity? user;

  const AuthState.unknown() : this._();

  const AuthState.authenticated(UserEntity user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}
