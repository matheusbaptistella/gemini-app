part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  SignUpState({
    Email? email,
    Password? password,
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.name = const Name.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.errorMessage,
  })  : email = email ?? Email.pure(),
        password = password ?? Password.pure();

  final bool isValid;
  final FormzSubmissionStatus status;
  final Name name;
  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final String? errorMessage;

  @override
  List<Object?> get props =>
      [isValid, status, name, email, password, confirmedPassword, errorMessage];

  SignUpState copyWith({
    bool? isValid,
    FormzSubmissionStatus? status,
    Name? name,
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    String? errorMessage,
  }) {
    return SignUpState(
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
