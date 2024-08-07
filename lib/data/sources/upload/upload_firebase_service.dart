import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/data/models/upload/profile_picture_req.dart';
import 'package:image_picker/image_picker.dart';

abstract class UploadFirebaseService {
  Future<File> selectProfilePicture();
  Future<String> uploadProfilePicture(UploadProfilePictureReq req);
}

class UploadFirebaseServiceImpl implements UploadFirebaseService {
  final FirebaseStorage _firebaseStorage;

  UploadFirebaseServiceImpl({
    FirebaseStorage? firebaseStorage,
  }) : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Future<File> selectProfilePicture() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        throw SelectProfilePictureException(message: 'No picture selected.');
      }
      return File(pickedFile.path);
    } on PlatformException catch (e) {
      throw SelectProfilePictureException(message: e.message);
    } on FileSystemException catch (e) {
      throw SelectProfilePictureException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> uploadProfilePicture(UploadProfilePictureReq req) async {
    try {
      Reference storageReference = _firebaseStorage.ref().child(
          '${req.userId}/profile_pictures/${DateTime.now().toIso8601String()}');
      UploadTask uploadTask = storageReference.putFile(req.profilePicture);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw UploadProfilePictureException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }
}
