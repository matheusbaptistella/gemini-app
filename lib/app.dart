import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_theme.dart';
import 'package:gemini_app/presentation/auth/blocs/auth_bloc/auth_bloc.dart';
import 'package:gemini_app/presentation/auth/cubits/theme/theme_cubit.dart';
import 'package:gemini_app/presentation/auth/cubits/theme/theme_state.dart';
import 'package:gemini_app/presentation/auth/screens/sign_in.dart';
import 'package:gemini_app/presentation/home/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final brightness = MediaQuery.of(context).platformBrightness;
          context.read<ThemeCubit>().updateTheme(brightness);
          return MaterialApp(
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            home: BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: ((context, state) {
                  if (state.status == AuthStatus.authenticated) {
                    return const HomeScreen();
                  } else {
                    return const SignInScreen();
                  }
                }),
              ),
            ),
          );
        },
      ),
    );
  }
}
