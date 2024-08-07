part of 'update_profile_name_cubit.dart';

class UpdateProfileNameState extends Equatable {
  const UpdateProfileNameState({
    this.isValid = false,
    this.status = FormzSubmissionStatus.initial,
    this.name = const Name.pure(),
    this.errorMessage,
  });

  final bool isValid;
  final FormzSubmissionStatus status;
  final Name name;
  final String? errorMessage;

  @override
  List<Object?> get props => [isValid, status, name, errorMessage];

  UpdateProfileNameState copyWith({
    bool? isValid,
    FormzSubmissionStatus? status,
    Name? name,
    String? errorMessage,
  }) {
    return UpdateProfileNameState(
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      name: name ?? this.name,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
