import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/core/usecase/usecase.dart';
import 'package:gemini_app/domain/repository/upload/upload.dart';

import '../../../service_locator.dart';

class SelectProfilePictureUseCase
    implements UseCase<Either<Failure, File>, void> {
  @override
  Future<Either<Failure, File>> call({void params}) {
    return sl<UploadRepository>().selectProfilePicture();
  }
}
