import 'package:firebase_auth/firebase_auth.dart';

class SignUpWithEmailAndPasswordException extends FirebaseAuthException {
  SignUpWithEmailAndPasswordException({required super.code});
}

class SignInWithEmailAndPasswordException extends FirebaseAuthException {
  SignInWithEmailAndPasswordException({required super.code});
}
