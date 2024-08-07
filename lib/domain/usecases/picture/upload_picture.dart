import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/picture/upload_picture_req.dart';
import 'package:gemini_app/domain/repository/picture/picture.dart';

import '../../../service_locator.dart';

class UploadPictureUseCase
    implements UseCase<Either<Failure, String>, UploadPictureReq> {
  @override
  Future<Either<Failure, String>> call(
      {required UploadPictureReq params}) {
    return sl<PictureRepository>().uploadPicture(params);
  }
}
