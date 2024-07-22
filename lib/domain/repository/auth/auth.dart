import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';

abstract class AuthRepository {

  Future<void> logOut();

  Future<Either<Failure, void>> signIn(SignInUserReq req);

  Future<Either<Failure, UserEntity>> signUp(SignUpUserReq req);

  Stream<UserEntity> get user;
}