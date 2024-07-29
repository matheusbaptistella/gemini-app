import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/domain/entities/auth/user.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/confirmed_password.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/email.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/name.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/password.dart';

import '../../../../service_locator.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpState());

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
        name: name,
        isValid: Formz.validate(
            [name, state.email, state.password, state.confirmedPassword])));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
            [state.name, email, state.password, state.confirmedPassword]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate(
            [state.name, state.email, password, state.confirmedPassword]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.name,
          state.email,
          state.password,
          confirmedPassword,
        ]),
      ),
    );
  }

  Future<void> signUpWithEmailAndPassword() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final Either<Failure, UserEntity> result = await sl<AuthRepository>()
        .signUp(SignUpUserReq(
            name: state.name.value,
            email: state.email.value,
            password: state.password.value));
    result.fold(
      (failure) => emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }

  // TODO: Sign up with google
}
