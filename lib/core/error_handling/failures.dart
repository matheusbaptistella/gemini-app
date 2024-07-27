abstract class Failure {
  final String message;

  const Failure({required this.message});
}

class SignInWithEmailAndPasswordFailure extends Failure {
  const SignInWithEmailAndPasswordFailure(
      {super.message = 'An unknown sign in exception occurred.'});

  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Account not found. Please Sign Up',
        );
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Email is not valid or badly formatted.',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          message:
              'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Email not found, please sign up.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          message: 'Incorrect password, please try again.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }
}

class SignUpWithEmailAndPasswordFailure extends Failure {
  const SignUpWithEmailAndPasswordFailure(
      {super.message = 'An unknown sign up exception occurred.'});

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-credential':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Account not found or credentials malformed.',
        );
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Email is not valid or badly formatted.',
        );
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'An account already exists with this email.',
        );
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
          message:
              'This user has been disabled. Please contact support for help.',
        );
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Operation is not allowed. Please contact support.',
        );
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          message: 'Please enter a stronger password.',
        );
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

class SignInWithGoogleFailure extends Failure {
  const SignInWithGoogleFailure(
      {super.message = 'An unknown google sign in exception occurred.'});

  factory SignInWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return const SignInWithGoogleFailure(
          message: 'Account exists with different credentials.',
        );
      case 'invalid-credential':
        return const SignInWithGoogleFailure(
          message: 'The credential received is malformed or has expired.',
        );
      case 'operation-not-allowed':
        return const SignInWithGoogleFailure(
          message: 'Operation is not allowed.  Please contact support.',
        );
      case 'user-disabled':
        return const SignInWithGoogleFailure(
          message: 'This user has been disabled. Please contact support for help.',
        );
      case 'user-not-found':
        return const SignInWithGoogleFailure(
          message: 'Email is not found, please create an account.',
        );
      case 'wrong-password':
        return const SignInWithGoogleFailure(
          message: 'Incorrect password, please try again.',
        );
      case 'invalid-verification-code':
        return const SignInWithGoogleFailure(
          message: 'The credential verification code received is invalid.',
        );
      case 'invalid-verification-id':
        return const SignInWithGoogleFailure(
          message: 'The credential verification ID received is invalid.',
        );
      default:
        return const SignInWithGoogleFailure();
    }
  }
}