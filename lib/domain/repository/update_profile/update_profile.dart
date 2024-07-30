import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';

abstract class UpdateProfile {
  Future<Either<Failure, void>> updateProfilePicture();
}