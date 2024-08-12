part of 'update_profile_picture_cubit.dart';

sealed class UpdateProfilePictureState extends Equatable {
  const UpdateProfilePictureState();

  @override
  List<Object> get props => [];
}

class UpdateProfilePictureInitial extends UpdateProfilePictureState {}

class UpdateProfilePictureSelected extends UpdateProfilePictureState {
  const UpdateProfilePictureSelected({required this.profilePicture});

  final File profilePicture;

  @override
  List<Object> get props => [profilePicture];
}

class UpdateProfilePictureSuccess extends UpdateProfilePictureState {}

class UpdateProfilePictureError extends UpdateProfilePictureState {
  const UpdateProfilePictureError({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
