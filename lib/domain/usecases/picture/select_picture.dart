import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/data/models/picture/select_picture_req.dart';
import 'package:gemini_app/domain/repository/picture/picture.dart';

import '../../../service_locator.dart';

class SelectPictureUseCase
    implements UseCase<Either<Failure, File>, SelectPictureReq> {
  @override
  Future<Either<Failure, File>> call({required SelectPictureReq params}) {
    return sl<PictureRepository>().selectPicture(params);
  }
}
