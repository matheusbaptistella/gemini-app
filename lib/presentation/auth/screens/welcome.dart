import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:gemini_app/presentation/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:gemini_app/presentation/auth/screens/sign_in.dart';
import 'package:gemini_app/presentation/auth/widgets/auth_options.dart';
import 'package:gemini_app/presentation/auth/widgets/sign_in_form.dart';
import 'package:gemini_app/presentation/auth/screens/sign_up.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                ),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      'New to this app?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        // Switch to sign up screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (_) => SignUpBloc(),
                              child: const SignUpScreen(),
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationThickness: 1,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocProvider<SignInBloc>(
                  create: (_) => SignInBloc(),
                  child: const SignInScreen(),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     'Forgot password?',
                //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                //       color: AppColors.kZambeziColor,
                //       fontSize: 14,
                //       decoration: TextDecoration.underline,
                //       decorationThickness: 1,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Or sign in with:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.kBlackColor,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Button to sign with Google authentication
                const AuthOptions(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}