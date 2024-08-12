import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/presentation/auth/cubits/sign_in/sign_in_cubit.dart';
import 'package:gemini_app/presentation/auth/screens/sign_in_form.dart';
import 'package:gemini_app/presentation/auth/screens/welcome.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: BlocProvider<SignInCubit>(
        create: (_) => SignInCubit(),
        child: screenWidth <= 1024
            ? const SignInForm()
            : const Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: SignInForm(),
                  ),
                  Expanded(
                    flex: 5,
                    child: WelcomeScreen(),
                  ),
                ],
              ),
      ),
    );
  }
}
