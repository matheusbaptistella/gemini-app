import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignUpUseCase
    implements UseCase<Either<Failure, UserEntity>, SignUpUserReq> {
  @override
  Future<Either<Failure, UserEntity>> call({SignUpUserReq? params}) async {
    return sl<AuthRepository>().signUp(params!);
  }
}
