import 'package:gemini_app/data/repository/auth/auth_repository_impl.dart';
import 'package:gemini_app/data/repository/profile/profile_repository_impl.dart';
import 'package:gemini_app/data/repository/upload/upload_repository_impl.dart';
import 'package:gemini_app/data/sources/auth/auth_firebase_service.dart';
import 'package:gemini_app/data/sources/profile/profile_firebase_service.dart';
import 'package:gemini_app/data/sources/upload/upload_firebase_service.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';
import 'package:gemini_app/domain/repository/profile/profile.dart';
import 'package:gemini_app/domain/repository/upload/upload.dart';
import 'package:gemini_app/domain/usecases/auth/reset_password.dart';
import 'package:gemini_app/domain/usecases/auth/sign_in.dart';
import 'package:gemini_app/domain/usecases/auth/sign_in_with_google.dart';
import 'package:gemini_app/domain/usecases/auth/sign_up.dart';
import 'package:gemini_app/domain/usecases/profile/update_name.dart';
import 'package:gemini_app/domain/usecases/profile/update_picture_url.dart';
import 'package:gemini_app/domain/usecases/upload/select_profile_picture.dart';
import 'package:gemini_app/domain/usecases/upload/upload_profile_picture.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase());

  sl.registerSingleton<ResetPasswordWithEmailUseCase>(
      ResetPasswordWithEmailUseCase());

  sl.registerSingleton<ProfileFirebaseService>(ProfileFirebaseServiceImpl());

  sl.registerSingleton<ProfileRepository>(ProfileRepositoryImpl());

  sl.registerSingleton<UpdateProfileNameUseCase>(UpdateProfileNameUseCase());

  sl.registerSingleton<UpdateProfilePictureUrlUseCase>(
      UpdateProfilePictureUrlUseCase());

  sl.registerSingleton<UploadFirebaseService>(UploadFirebaseServiceImpl());

  sl.registerSingleton<UploadRepository>(UploadRepositoryImpl());

  sl.registerSingleton<SelectProfilePictureUseCase>(
      SelectProfilePictureUseCase());

  sl.registerSingleton<UploadProfilePictureUseCase>(
      UploadProfilePictureUseCase());
}
