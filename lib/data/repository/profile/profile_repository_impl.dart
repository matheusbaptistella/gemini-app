import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/profile/update_name_req.dart';
import 'package:gemini_app/data/models/profile/update_picture_url_req.dart';
import 'package:gemini_app/data/sources/profile/profile_firebase_service.dart';
import 'package:gemini_app/domain/entities/user.dart';
import 'package:gemini_app/domain/repository/profile/profile.dart';

import '../../../service_locator.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Either<Failure, void>> updateProfileName(
      UpdateProfileNameReq req) async {
    try {
      return Right(await sl<ProfileFirebaseService>().updateProfileName(req));
    } on UpdateProfileNameException catch (e) {
      return Left(UpdateProfileNameFailure(message: e.message));
    } catch (_) {
      return const Left(UpdateProfileNameFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateProfilePictureUrl(
      UpdateProfilePictureUrlReq req) async {
    try {
      return Right(
          await sl<ProfileFirebaseService>().updateProfilePictureUrl(req));
    } on UpdateProfilePictureUrlException catch (e) {
      return Left(UpdateProfilePictureUrlFailure(message: e.message));
    } catch (_) {
      return const Left(UpdateProfilePictureUrlFailure());
    }
  }

  @override
  Stream<UserEntity> getUserProfile(String userId) =>
      sl<ProfileFirebaseService>()
          .getUserProfile(userId)
          .map((user) => user.toEntity());
}
