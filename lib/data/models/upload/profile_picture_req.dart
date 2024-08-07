import 'dart:io';

class UploadProfilePictureReq {
  final String userId;
  final File profilePicture;

  UploadProfilePictureReq({required this.userId, required this.profilePicture});
}
