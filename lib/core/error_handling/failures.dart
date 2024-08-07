abstract class Failure {
  final String message;

  const Failure({required this.message});
}

class SignInWithEmailAndPasswordFailure extends Failure {
  const SignInWithEmailAndPasswordFailure({String? message})
      : super(
            message:
                message ?? 'An unknown exception occurred when signing in.');
}

class SignUpWithEmailAndPasswordFailure extends Failure {
  const SignUpWithEmailAndPasswordFailure({String? message})
      : super(
            message:
                message ?? 'An unknown exception occurred when signing up.');
}

class SignInWithGoogleFailure extends Failure {
  const SignInWithGoogleFailure({String? message})
      : super(
            message: message ??
                'An unknown exception occurred when signing in with Google.');
}

class ResetPasswordWithEmailFailure extends Failure {
  const ResetPasswordWithEmailFailure({String? message})
      : super(
            message: message ??
                'An unknown exception occurred when resetting the password.');
}

class UpdateProfileNameFailure extends Failure {
  const UpdateProfileNameFailure({String? message})
      : super(
            message: message ??
                'An unknown exception occurred when updating the profile name.');
}

class UpdateProfilePictureUrlFailure extends Failure {
  const UpdateProfilePictureUrlFailure({String? message})
      : super(
            message: message ??
                'An unknown exception occurred when updating the profile picture url.');
}

class SelectProfilePictureFailure extends Failure {
  const SelectProfilePictureFailure({String? message})
      : super(
            message: message ??
                'An unknown exception occurred when selecting the profile picture.');
}

class UploadProfilePictureFailure extends Failure {
  const UploadProfilePictureFailure({String? message})
      : super(
            message: message ??
                'An unknown exception occurred when uploading the profile picture.');
}
