import 'package:gemini_app/data/repository/auth/auth_repository_impl.dart';
import 'package:gemini_app/data/repository/profile/profile_repository_impl.dart';
import 'package:gemini_app/data/repository/picture/picture_repository_impl.dart';
import 'package:gemini_app/data/sources/auth/auth_firebase_service.dart';
import 'package:gemini_app/data/sources/profile/profile_firebase_service.dart';
import 'package:gemini_app/data/sources/picture/picture_firebase_service.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';
import 'package:gemini_app/domain/repository/profile/profile.dart';
import 'package:gemini_app/domain/repository/picture/picture.dart';
import 'package:gemini_app/domain/usecases/auth/reset_password.dart';
import 'package:gemini_app/domain/usecases/auth/sign_in.dart';
import 'package:gemini_app/domain/usecases/auth/sign_in_with_google.dart';
import 'package:gemini_app/domain/usecases/auth/sign_up.dart';
import 'package:gemini_app/domain/usecases/profile/update_name.dart';
import 'package:gemini_app/domain/usecases/profile/update_picture_url.dart';
import 'package:gemini_app/domain/usecases/picture/select_picture.dart';
import 'package:gemini_app/domain/usecases/picture/upload_picture.dart';
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

  sl.registerSingleton<PictureFirebaseService>(PictureFirebaseServiceImpl());

  sl.registerSingleton<PictureRepository>(PictureRepositoryImpl());

  sl.registerSingleton<SelectPictureUseCase>(
      SelectPictureUseCase());

  sl.registerSingleton<UploadPictureUseCase>(
      UploadPictureUseCase());
}
