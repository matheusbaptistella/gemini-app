import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gemini_app/core/error_handling/exceptions.dart';
import 'package:gemini_app/data/models/profile/update_profile_name_req.dart';
import 'package:gemini_app/data/models/profile/update_profile_picture_url_req.dart';
import 'package:gemini_app/data/models/user.dart';
import 'package:rxdart/transformers.dart';

abstract class ProfileFirebaseService {
  Future<void> updateProfileName(UpdateProfileNameReq req);
  Future<void> updateProfilePictureUrl(UpdateProfilePictureUrlReq req);
  Stream<UserModel> getUserProfile(String userId);
}

class ProfileFirebaseServiceImpl implements ProfileFirebaseService {
  final FirebaseFirestore _firebaseFirestore;

  ProfileFirebaseServiceImpl({
    FirebaseFirestore? firebaseFirestore,
  }) : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Future<void> updateProfileName(UpdateProfileNameReq req) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(req.userId)
          .update({'name': req.name});
    } on FirebaseException catch (e) {
      log(e.toString());
      throw UpdateProfileNameException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateProfilePictureUrl(UpdateProfilePictureUrlReq req) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(req.userId)
          .update({'profile_picture_url': req.profilePictureUrl});
    } on FirebaseException catch (e) {
      log(e.toString());
      throw UpdateProfilePictureUrlException(message: e.message);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<UserModel> getUserProfile(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .flatMap((DocumentSnapshot<Map<String, dynamic>> snapshot) async* {
      if (snapshot.exists) {
        log('NReceived change on user');
        yield UserModel.fromJson(snapshot.data()!);
      }
    });
  }
}
