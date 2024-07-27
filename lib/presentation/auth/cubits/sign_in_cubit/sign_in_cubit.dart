import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/email.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/password.dart';

import '../../../../service_locator.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  Future<void> signInWithEmailAndPassword() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final Either<Failure, void> result = await sl<AuthRepository>().signIn(
        SignInUserReq(
            email: state.email.value, password: state.password.value));
    result.fold(
      (failure) => emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }

  Future<void> signInWithGoogle() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final Either<Failure, void> result = await sl<AuthRepository>().signInWithGoogle();
    result.fold(
      (failure) => emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }
}
