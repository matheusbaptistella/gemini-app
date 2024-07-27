import 'package:firebase_auth/firebase_auth.dart';

class SignInWithEmailAndPasswordException extends FirebaseAuthException {
  SignInWithEmailAndPasswordException({required super.code});
}

class SignUpWithEmailAndPasswordException extends FirebaseAuthException {
  SignUpWithEmailAndPasswordException({required super.code});
}

class SignInWithGoogleException extends FirebaseAuthException {
  SignInWithGoogleException({required super.code});
}