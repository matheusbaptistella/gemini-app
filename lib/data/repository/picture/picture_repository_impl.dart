import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/picture/select_picture_req.dart';
import 'package:gemini_app/data/models/picture/upload_picture_req.dart';
import 'package:gemini_app/data/sources/picture/picture_firebase_service.dart';
import 'package:gemini_app/domain/repository/picture/picture.dart';

import '../../../service_locator.dart';

class PictureRepositoryImpl implements PictureRepository {
  @override
  Future<Either<Failure, File>> selectPicture(SelectPictureReq req) async {
    try {
      return Right(await sl<PictureFirebaseService>().selectPicture(req));
    } on SelectPictureException catch (e) {
      return Left(SelectPictureFailure(message: e.message));
    } catch (_) {
      return const Left(SelectPictureFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadPicture(UploadPictureReq req) async {
    try {
      return Right(await sl<PictureFirebaseService>().uploadPicture(req));
    } on UploadPictureException catch (e) {
      return Left(UploadPictureFailure(message: e.message));
    } catch (_) {
      return const Left(UploadPictureFailure());
    }
  }
}
