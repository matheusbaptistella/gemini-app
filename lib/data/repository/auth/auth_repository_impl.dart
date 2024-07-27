import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/data/sources/auth/auth_firebase_service.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<void> logOut() async {
    return await sl<AuthFirebaseService>().logOut();
  }

  @override
  Future<Either<Failure, void>> signIn(SignInUserReq req) async {
    try {
      return Right(await sl<AuthFirebaseService>().signIn(req));
    } on SignInWithEmailAndPasswordException catch (e) {
      return Left(SignInWithEmailAndPasswordFailure.fromCode(e.code));
    } catch (_) {
      return const Left(SignInWithEmailAndPasswordFailure());
    }
  }

  Future<Either<Failure, void>> signInWithGoogle() async {
    try {
      return Right(await sl<AuthFirebaseService>().signInWithGoogle());
    } on SignInWithGoogleException catch (e) {
      throw Left(SignInWithGoogleFailure.fromCode(e.code));
    } catch (_) {
      return const Left(SignInWithGoogleFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(SignUpUserReq req) async {
    try {
      final user = await sl<AuthFirebaseService>().signUp(req);
      return Right(user.toEntity());
    } on SignUpWithEmailAndPasswordException catch (e) {
      return Left(SignUpWithEmailAndPasswordFailure.fromCode(e.code));
    } catch (_) {
      return const Left(SignUpWithEmailAndPasswordFailure());
    }
  }

  @override
  Stream<UserEntity> get user =>
      sl<AuthFirebaseService>().user.map((user) => user.toEntity());
}
