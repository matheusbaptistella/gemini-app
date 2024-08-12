import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/data/models/auth/reset_password_req.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/data/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/transformers.dart';

abstract class AuthFirebaseService {
  Future<void> signOut();
  Future<void> signIn(SignInUserReq req);
  Future<void> signInWithGoogle();
  Future<UserModel> signUp(SignUpUserReq req);
  Future<void> resetPasswordWithEmail(ResetPasswordWithEmailReq req);
  Stream<UserModel> get userAuth;
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseServiceImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signIn(SignInUserReq req) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: req.email, password: req.password);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw SignInWithEmailAndPasswordException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      late final AuthCredential credential;
      if (kIsWeb) {
        final googleProvider = GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(
          googleProvider,
        );
        credential = userCredential.credential!;
      } else {
        final googleUser = await GoogleSignIn().signIn();
        final googleAuth = await googleUser!.authentication;
        credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw SignInWithGoogleException(message: e.message);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(SignUpUserReq req) async {
    try {
      UserCredential data = await _firebaseAuth.createUserWithEmailAndPassword(
          email: req.email, password: req.password);
      UserModel model = UserModel(
          userId: data.user!.uid,
          email: req.email,
          name: req.name,
          profilePictureUrl: '');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(data.user?.uid)
          .set(model.toJson());
      return model;
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw SignUpWithEmailAndPasswordException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> resetPasswordWithEmail(ResetPasswordWithEmailReq req) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: req.email);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      throw ResetPasswordWithEmailException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<UserModel> get userAuth {
    return _firebaseAuth.authStateChanges().flatMap((firebaseUser) async* {
      if (firebaseUser == null) {
        yield UserModel.empty;
      } else {
        yield await FirebaseFirestore.instance
            .collection('users')
            .doc(firebaseUser.uid)
            .get()
            .then((value) => UserModel.fromJson(value.data()!));
      }
    });
  }
}
