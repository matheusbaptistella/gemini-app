import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/picture/select_picture_req.dart';
import 'package:gemini_app/data/models/picture/upload_picture_req.dart';

abstract class PictureRepository {
  Future<Either<Failure, File>> selectPicture(SelectPictureReq req);
  Future<Either<Failure, String>> uploadPicture(
      UploadPictureReq req);
}
