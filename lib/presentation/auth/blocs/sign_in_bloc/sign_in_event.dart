part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInRequired extends SignInEvent {
  final SignInUserReq req;
  const SignInRequired(this.req);

  @override
  List<Object> get props => [req];
}

class SignOutRequired extends SignInEvent {}