import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../service_locator.dart';

class SignInWithGoogleUseCase implements UseCase<Either<Failure, void>, void> {
  @override
  Future<Either<Failure, void>> call({void params}) async {
    return sl<AuthRepository>().signInWithGoogle();
  }
}