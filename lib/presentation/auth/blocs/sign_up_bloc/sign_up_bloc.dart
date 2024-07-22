import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';

import '../../../../service_locator.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());

      final Either<Failure, UserEntity> result = await sl<AuthRepository>().signUp(event.req);

      result.fold(
        (failure) => emit(SignUpFailure()),
        (user) => emit(SignUpSuccess()),
      );
    });
  }
}
