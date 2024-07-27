import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/data/models/auth/user.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/transformers.dart';

abstract class AuthFirebaseService {
  Future<void> logOut();

  Future<void> signIn(SignInUserReq req);

  Future<void> signInWithGoogle();

  Future<UserModel> signUp(SignUpUserReq req);

  Stream<UserModel> get user;
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  final FirebaseAuth _firebaseAuth;

  AuthFirebaseServiceImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signIn(SignInUserReq req) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: req.email, password: req.password);
    } on FirebaseAuthException catch (e) {
      log("${e.toString()}, ${e.code}");
      throw SignInWithEmailAndPasswordException(code: e.code);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      // TODO: for the web, see google_sing_in_web plugin
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      log("${e.toString()}, ${e.code}");
      throw SignInWithGoogleException(code: e.code);
    } catch (e) {
      log("${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(SignUpUserReq req) async {
    try {
      UserCredential data = await _firebaseAuth.createUserWithEmailAndPassword(
          email: req.email, password: req.password);
      UserEntity entity = UserEntity(email: req.email, name: req.name);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(data.user?.uid)
          .set(UserModel.fromEntity(entity).toJson());
      return UserModel(email: req.email, name: req.name);
    } on FirebaseAuthException catch (e) {
      log("${e.toString()}, ${e.code}");
      throw SignUpWithEmailAndPasswordException(code: e.code);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<UserModel> get user {
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
