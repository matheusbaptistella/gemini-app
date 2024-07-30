import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/auth/reset_password_req.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class ResetPasswordWithEmailUseCase implements UseCase<Either<Failure, void>, ResetPasswordWithEmailReq> {
  @override
  Future<Either<Failure, void>> call({required ResetPasswordWithEmailReq params}) async {
    return sl<AuthRepository>().resetPasswordWithEmail(params);
  }

}