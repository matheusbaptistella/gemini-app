import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/reset_password_req.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/data/sources/auth/auth_firebase_service.dart';
import 'package:gemini_app/domain/entities/user.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> signOut() async {
    return await sl<AuthFirebaseService>().signOut();
  }

  @override
  Future<Either<Failure, void>> signIn(SignInUserReq req) async {
    try {
      return Right(await sl<AuthFirebaseService>().signIn(req));
    } on SignInWithEmailAndPasswordException catch (e) {
      return Left(SignInWithEmailAndPasswordFailure(message: e.message));
    } catch (_) {
      return const Left(SignInWithEmailAndPasswordFailure());
    }
  }

  @override
  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      return Right(await sl<AuthFirebaseService>().signInWithGoogle());
    } on SignInWithGoogleException catch (e) {
      throw Left(SignInWithGoogleFailure(message: e.message));
    } catch (_) {
      return const Left(SignInWithGoogleFailure());
    }
  }

  @override
  Future<Either<Failure, void>> resetPasswordWithEmail(
      ResetPasswordWithEmailReq req) async {
    try {
      return Right(await sl<AuthFirebaseService>().resetPasswordWithEmail(req));
    } on ResetPasswordWithEmailException catch (e) {
      return Left(ResetPasswordWithEmailFailure(message: e.message));
    } catch (_) {
      return const Left(ResetPasswordWithEmailFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(SignUpUserReq req) async {
    try {
      final user = await sl<AuthFirebaseService>().signUp(req);
      return Right(user.toEntity());
    } on SignUpWithEmailAndPasswordException catch (e) {
      return Left(SignUpWithEmailAndPasswordFailure(message: e.message));
    } catch (_) {
      return const Left(SignUpWithEmailAndPasswordFailure());
    }
  }

  @override
  Stream<UserEntity> get userAuth =>
      sl<AuthFirebaseService>().userAuth.map((user) => user.toEntity());
}
