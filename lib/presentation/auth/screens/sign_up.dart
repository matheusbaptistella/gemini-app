import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/presentation/auth/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:gemini_app/presentation/auth/screens/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocProvider<SignUpCubit>(
        create: (_) => SignUpCubit(),
        child: const SignUpForm(),
      ),
    );
  }
}
