import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_theme.dart';
import 'package:gemini_app/presentation/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:gemini_app/presentation/auth/cubits/theme/theme_cubit.dart';
import 'package:gemini_app/presentation/auth/cubits/theme/theme_state.dart';
import 'package:gemini_app/presentation/auth/screens/sign_in.dart';
import 'package:gemini_app/presentation/home/cubits/profile_cubit/profile_cubit.dart';
import 'package:gemini_app/presentation/home/screens/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(
          create: (_) => ThemeCubit(),
        ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(),
        ),
      ],
      child: const MyAppView(),
    );
  }
}

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        final brightness = MediaQuery.of(context).platformBrightness;
        context.read<ThemeCubit>().updateTheme(brightness);
        return BlocBuilder<AuthCubit, AuthState>(
          builder: ((context, authState) {
            if (authState is AuthStateAuthenticated) {
              return BlocProvider<ProfileCubit>(
                create: (_) => ProfileCubit(userParam: authState.user),
                child: MaterialApp(
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeState.themeMode,
                  home: const HomeScreen(),
                ),
              );
            } else {
              return MaterialApp(
                  theme: AppTheme.lightTheme,
                  darkTheme: AppTheme.darkTheme,
                  themeMode: themeState.themeMode,
                  home: const SignInScreen());
            }
          }),
        );
      },
    );
  }
}

// class MyAppVi extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<ThemeCubit>(
//       create: (_) => ThemeCubit(),
//       child: BlocBuilder<ThemeCubit, ThemeState>(
//         builder: (context, themeState) {
//           final brightness = MediaQuery.of(context).platformBrightness;
//           context.read<ThemeCubit>().updateTheme(brightness);
//           return BlocProvider<AuthCubit>(
//             create: (_) => AuthCubit(),
//             child: MaterialApp(
//               theme: AppTheme.lightTheme,
//               darkTheme: AppTheme.darkTheme,
//               themeMode: themeState.themeMode,
//               home: BlocBuilder<AuthCubit, AuthState>(
//                 builder: ((context, authState) {
//                   if (authState is AuthStateAuthenticated) {
//                     return BlocProvider<ProfileCubit>(
//                       create: (context) =>
//                           ProfileCubit(userParam: authState.user),
//                       child: const HomeScreen(),
//                     );
//                   } else {
//                     return const SignInScreen();
//                   }
//                 }),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
