import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/profile/update_profile_name_req.dart';
import 'package:gemini_app/data/models/profile/update_profile_picture_url_req.dart';
import 'package:gemini_app/domain/entities/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, void>> updateProfileName(UpdateProfileNameReq req);
  Future<Either<Failure, void>> updateProfilePictureUrl(
      UpdateProfilePictureUrlReq req);
  Stream<UserEntity> getUserProfile(String userId);
}
