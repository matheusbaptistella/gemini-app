part of 'reset_password_cubit.dart';

class ResetPasswordState extends Equatable {
  ResetPasswordState({
    Email? email,
    FormzSubmissionStatus? status,
    bool? isValid,
    this.errorMessage,
  })  : email = email ?? Email.pure(),
        status = status ?? FormzSubmissionStatus.initial,
        isValid = isValid ?? false;

  final Email email;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [email, status, isValid, errorMessage];

  ResetPasswordState copyWith({
    Email? email,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
