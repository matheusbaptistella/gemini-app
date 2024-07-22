part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequired extends SignUpEvent {
  final SignUpUserReq req;

  const SignUpRequired(this.req);

  @override
  List<Object> get props => [req];
}
