import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/upload/profile_picture_req.dart';
import 'package:gemini_app/data/sources/upload/upload_firebase_service.dart';
import 'package:gemini_app/domain/repository/upload/upload.dart';

import '../../../service_locator.dart';

class UploadRepositoryImpl implements UploadRepository {
  @override
  Future<Either<Failure, File>> selectProfilePicture() async {
    try {
      return Right(await sl<UploadFirebaseService>().selectProfilePicture());
    } on SelectProfilePictureException catch (e) {
      return Left(SelectProfilePictureFailure(message: e.message));
    } catch (_) {
      return const Left(SelectProfilePictureFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(
      UploadProfilePictureReq req) async {
    try {
      return Right(await sl<UploadFirebaseService>().uploadProfilePicture(req));
    } on UploadProfilePictureException catch (e) {
      return Left(UploadProfilePictureFailure(message: e.message));
    } catch (_) {
      return const Left(UploadProfilePictureFailure());
    }
  }
}
