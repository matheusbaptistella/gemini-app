import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/presentation/auth/cubits/sign_in/sign_in_cubit.dart';
import 'package:gemini_app/presentation/auth/screens/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocProvider<SignInCubit>(
        create: (_) => SignInCubit(),
        child: const SignInForm(),
      ),
    );
  }
}
