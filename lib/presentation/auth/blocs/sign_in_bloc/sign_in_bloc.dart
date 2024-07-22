import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../../service_locator.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());

      final Either<Failure, void> result = await sl<AuthRepository>().signIn(event.req);
      
      result.fold(
        (failure) => emit(SignInFailure()),
        (_) => emit(SignInSuccess()),
      );
    });

    on<SignOutRequired>((event, emit) async => await sl<AuthRepository>().logOut());
  }
}
