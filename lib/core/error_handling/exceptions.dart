class CustomException implements Exception {
  CustomException({this.message});

  final String? message;
}

class SignInWithEmailAndPasswordException extends CustomException {
  SignInWithEmailAndPasswordException({super.message});
}

class SignUpWithEmailAndPasswordException extends CustomException {
  SignUpWithEmailAndPasswordException({super.message});
}

class SignInWithGoogleException extends CustomException {
  SignInWithGoogleException({super.message});
}

class ResetPasswordWithEmailException extends CustomException {
  ResetPasswordWithEmailException({super.message});
}

class UpdateProfileNameException extends CustomException {
  UpdateProfileNameException({super.message});
}

class UpdateProfilePictureUrlException extends CustomException {
  UpdateProfilePictureUrlException({super.message});
}

class SelectPictureException extends CustomException {
  SelectPictureException({super.message});
}

class UploadPictureException extends CustomException {
  UploadPictureException({super.message});
}
