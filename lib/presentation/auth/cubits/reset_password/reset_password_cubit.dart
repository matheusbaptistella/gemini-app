import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/auth/reset_password_req.dart';
import 'package:gemini_app/domain/usecases/auth/reset_password.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/email.dart';

import '../../../../service_locator.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
  }

  Future<void> resetPasswordWIthEmail() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    // final Either<Failure, void> result = await sl<AuthRepository>()
    //     .resetPasswordWithEmail(
    //         ResetPasswordWithEmailReq(email: state.email.value));
    final Either<Failure, void> result =
        await sl<ResetPasswordWithEmailUseCase>().call(
      params: ResetPasswordWithEmailReq(email: state.email.value),
    );
    result.fold(
      (failure) => emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }
}
