import 'package:gemini_app/data/repository/auth/auth_repository_impl.dart';
import 'package:gemini_app/data/sources/auth/auth_firebase_service.dart';
import 'package:gemini_app/domain/repository/auth/auth.dart';
import 'package:gemini_app/domain/usecases/auth/reset_password.dart';
import 'package:gemini_app/domain/usecases/auth/sign_in.dart';
import 'package:gemini_app/domain/usecases/auth/sign_in_with_google.dart';
import 'package:gemini_app/domain/usecases/auth/sign_up.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignUpUseCase>(SignUpUseCase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  sl.registerSingleton<SignInWithGoogleUseCase>(SignInWithGoogleUseCase());

  sl.registerSingleton<ResetPasswordWithEmailUseCase>(ResetPasswordWithEmailUseCase());
}
