import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/profile/update_picture_url_req.dart';
import 'package:gemini_app/data/models/upload/profile_picture_req.dart';
import 'package:gemini_app/domain/usecases/profile/update_picture_url.dart';
import 'package:gemini_app/domain/usecases/upload/select_profile_picture.dart';
import 'package:gemini_app/domain/usecases/upload/upload_profile_picture.dart';

import '../../../../service_locator.dart';

part 'update_profile_picture_state.dart';

class UpdateProfilePictureCubit extends Cubit<UpdateProfilePictureState> {
  UpdateProfilePictureCubit({required this.userId})
      : super(UpdateProfilePictureInitial());

  final String userId;

  Future<void> updateProfilePicture() async {
    final Either<Failure, File> pictureResult =
        await sl<SelectProfilePictureUseCase>().call();
    pictureResult.fold(
      (failure) =>
          emit(UpdateProfilePictureError(errorMessage: failure.message)),
      (picture) async {
        emit(UpdateProfilePictureSelected(profilePicture: picture));
        final Either<Failure, String> uploadResult =
            await sl<UploadProfilePictureUseCase>().call(
                params: UploadProfilePictureReq(
                    userId: userId, profilePicture: picture));
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
