import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/reset_password_req.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';

abstract class AuthRepository {
  Future<void> logOut();
  Future<Either<Failure, void>> signIn(SignInUserReq req);
  Future<Either<Failure, void>> signInWithGoogle();
  Future<Either<Failure, UserEntity>> signUp(SignUpUserReq req);
  Future<Either<Failure, void>> resetPasswordWithEmail(
      ResetPasswordWithEmailReq req);
  Stream<UserEntity> get user;
}
