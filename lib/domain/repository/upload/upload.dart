import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/upload/profile_picture_req.dart';

abstract class UploadRepository {
  Future<Either<Failure, File>> selectProfilePicture();
  Future<Either<Failure, String>> uploadProfilePicture(
      UploadProfilePictureReq req);
}
