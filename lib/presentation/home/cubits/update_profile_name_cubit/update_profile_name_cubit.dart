import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/error_handling/failures.dart';
import 'package:gemini_app/data/models/profile/update_profile_name_req.dart';
import 'package:gemini_app/domain/usecases/profile/update_name.dart';
import 'package:gemini_app/presentation/auth/widgets/forms/name.dart';

import '../../../../service_locator.dart';

part 'update_profile_name_state.dart';

class UpdateProfileNameCubit extends Cubit<UpdateProfileNameState> {
  UpdateProfileNameCubit({required this.userId})
      : super(const UpdateProfileNameState());

  final String userId;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(name: name, isValid: Formz.validate([name])));
  }

  Future<void> updateProfileName() async {
    if (!state.isValid) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    final Either<Failure, void> result = await sl<UpdateProfileNameUseCase>()
        .call(
            params:
                UpdateProfileNameReq(userId: userId, name: state.name.value));
    result.fold(
      (failure) => emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: failure.message)),
      (_) => emit(state.copyWith(status: FormzSubmissionStatus.success)),
    );
  }
}
