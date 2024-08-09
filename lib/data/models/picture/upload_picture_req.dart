import 'dart:io';

class UploadPictureReq {
  final String userId;
  final File picture;
  final String location;

  UploadPictureReq(
      {required this.userId, required this.picture, required this.location});
}
