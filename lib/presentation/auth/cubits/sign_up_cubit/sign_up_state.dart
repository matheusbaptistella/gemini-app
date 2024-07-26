part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  SignUpState({
    this.name = const Name.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    this.errorMessage,
  })  : email = email ?? Email.pure(),
        password = password ?? Password.pure(),
        status = status ?? FormzSubmissionStatus.initial,
        isValid = isValid ?? false;

  final Name name;
  final ConfirmedPassword confirmedPassword;
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
    name, confirmedPassword, password, status, isValid, errorMessage
  ];

  SignUpState copyWith({
    Name? name,
    ConfirmedPassword? confirmedPassword,
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return SignUpState(
      name: name ?? this.name,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
