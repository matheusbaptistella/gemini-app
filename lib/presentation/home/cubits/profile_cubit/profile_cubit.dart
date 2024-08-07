import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/domain/entities/user.dart';
import 'package:gemini_app/domain/repository/profile/profile.dart';

import '../../../../service_locator.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required UserEntity userParam})
      : super(ProfileState(user: userParam)) {
    sl<ProfileRepository>()
        .getUserProfile(userParam.userId)
        .listen((UserEntity user) {
      log('New user being emitted');
      emit(ProfileState(user: user));
    });
  }
}
