import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignInUseCase implements UseCase<Either<Failure, void>, SignInUserReq> {
  @override
  Future<Either<Failure, void>> call({required SignInUserReq params}) async {
    return sl<AuthRepository>().signIn(params);
  }
}
