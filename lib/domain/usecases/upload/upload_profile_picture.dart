import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/upload/profile_picture_req.dart';
import 'package:gemini_app/domain/repository/upload/upload.dart';

import '../../../service_locator.dart';

class UploadProfilePictureUseCase
    implements UseCase<Either<Failure, String>, UploadProfilePictureReq> {
  @override
  Future<Either<Failure, String>> call(
      {required UploadProfilePictureReq params}) {
    return sl<UploadRepository>().uploadProfilePicture(params);
  }
}
