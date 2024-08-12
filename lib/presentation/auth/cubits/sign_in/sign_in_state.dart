part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  SignInState({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    this.errorMessage,
  })  : email = email ?? Email.pure(),
        password = password ?? Password.pure(),
        status = status ?? FormzSubmissionStatus.initial,
        isValid = isValid ?? false;

  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, password, status, isValid, errorMessage];

  SignInState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
