import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/data/models/user.dart';
import 'package:gemini_app/domain/entities/user.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../../service_locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthStateUnauthenticated()) {
    sl<AuthRepository>().userAuth.listen((UserEntity user) {
      if (user == UserModel.empty.toEntity()) {
        emit(const AuthStateUnauthenticated());
      } else {
        emit(AuthStateAuthenticated(user: user));
      }
    });
  }

  Future<void> signOut() async {
    await sl<AuthRepository>().signOut();
  }
}
