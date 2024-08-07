import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/profile/update_picture_url_req.dart';
import 'package:gemini_app/domain/repository/profile/profile.dart';

import '../../../service_locator.dart';

class UpdateProfilePictureUrlUseCase
    implements UseCase<Either<Failure, void>, UpdateProfilePictureUrlReq> {
  @override
  Future<Either<Failure, void>> call(
      {required UpdateProfilePictureUrlReq params}) async {
    return sl<ProfileRepository>().updateProfilePictureUrl(params);
  }
}
