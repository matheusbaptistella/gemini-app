import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/profile/update_profile_name_req.dart';
import 'package:gemini_app/domain/repository/profile/profile.dart';

import '../../../service_locator.dart';

class UpdateProfileNameUseCase
    implements UseCase<Either<Failure, void>, UpdateProfileNameReq> {
  @override
  Future<Either<Failure, void>> call(
      {required UpdateProfileNameReq params}) async {
    return sl<ProfileRepository>().updateProfileName(params);
  }
}
