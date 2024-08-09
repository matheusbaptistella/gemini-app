import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/data/models/picture/select_picture_req.dart';
import 'package:gemini_app/data/models/picture/upload_picture_req.dart';
import 'package:image_picker/image_picker.dart';

abstract class PictureFirebaseService {
  Future<File> selectPicture(SelectPictureReq req);
  Future<String> uploadPicture(UploadPictureReq req);
}

class PictureFirebaseServiceImpl implements PictureFirebaseService {
  final FirebaseStorage _firebaseStorage;

  PictureFirebaseServiceImpl({
    FirebaseStorage? firebaseStorage,
  }) : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  @override
  Future<File> selectPicture(SelectPictureReq req) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: req.source);
      if (pickedFile == null) {
        throw SelectPictureException(message: 'No picture selected.');
      }
      return File(pickedFile.path);
    } on PlatformException catch (e) {
      throw SelectPictureException(message: e.message);
    } on FileSystemException catch (e) {
      throw SelectPictureException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<String> uploadPicture(UploadPictureReq req) async {
    try {
      Reference storageReference = _firebaseStorage.ref().child(
          '${req.userId}/${req.location}/${DateTime.now().toIso8601String()}');
      UploadTask uploadTask = storageReference.putFile(req.picture);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      log(e.toString());
      throw UploadPictureException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }
}
