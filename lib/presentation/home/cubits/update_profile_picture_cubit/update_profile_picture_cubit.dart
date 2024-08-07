import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/picture/select_picture_req.dart';
import 'package:gemini_app/data/models/profile/update_profile_picture_url_req.dart';
import 'package:gemini_app/data/models/picture/upload_picture_req.dart';
import 'package:gemini_app/domain/usecases/profile/update_picture_url.dart';
import 'package:gemini_app/domain/usecases/picture/select_picture.dart';
import 'package:gemini_app/domain/usecases/picture/upload_picture.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../service_locator.dart';

part 'update_profile_picture_state.dart';

class UpdateProfilePictureCubit extends Cubit<UpdateProfilePictureState> {
  UpdateProfilePictureCubit({required this.userId})
      : super(UpdateProfilePictureInitial());

  final String userId;

  Future<void> updateProfilePicture() async {
    final Either<Failure, File> pictureResult =
        await sl<SelectPictureUseCase>().call(params: SelectPictureReq(source: ImageSource.gallery));
    pictureResult.fold(
      (failure) =>
          emit(UpdateProfilePictureError(errorMessage: failure.message)),
      (picture) async {
        emit(UpdateProfilePictureSelected(profilePicture: picture));
        final Either<Failure, String> uploadResult =
            await sl<UploadPictureUseCase>().call(
                params: UploadPictureReq(
                    userId: userId, picture: picture, location: "profile_pictures"));
        uploadResult.fold(
            (failure) =>
                emit(UpdateProfilePictureError(errorMessage: failure.message)),
            (url) async {
          final Either<Failure, void> updateUrlResult =
              await sl<UpdateProfilePictureUrlUseCase>().call(
                  params: UpdateProfilePictureUrlReq(
                      userId: userId, profilePictureUrl: url));
          updateUrlResult.fold(
              (failure) => emit(
                  UpdateProfilePictureError(errorMessage: failure.message)),
              (_) => emit(UpdateProfilePictureSuccess()));
        });
      },
    );
  }
}
