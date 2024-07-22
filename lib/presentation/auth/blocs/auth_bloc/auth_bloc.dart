import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/data/models/auth/user.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../../service_locator.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final StreamSubscription<UserEntity> _userSubscription;
  
  AuthBloc() : super(const AuthState.unknown()) {
    _userSubscription = sl<AuthRepository>().user.listen(
      (user) => add(AuthUserUpdated(user)),
    );

    on<AuthUserUpdated>((event, emit) {
      if(event.user != UserModel.empty.toEntity()) {
        emit(AuthState.authenticated(event.user!));
      } else {
        emit(const AuthState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
