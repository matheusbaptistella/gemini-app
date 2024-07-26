import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/auth/cubits/sign_in_cubit/sign_in_cubit.dart';
import 'package:gemini_app/presentation/auth/screens/sign_up.dart';
import 'package:gemini_app/presentation/auth/widgets/auth_options.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;
  IconData iconPassword = Icons.visibility;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
      iconPassword = obscurePassword ? Icons.visibility : Icons.visibility_off;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        // TODO: add success case
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'New to this app?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(width: 5),
                    _SignUpButton(),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: _EmailInput(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: _PasswordInput(
                    obscurePassword: obscurePassword,
                    iconPassword: iconPassword,
                    togglePasswordVisibility: togglePasswordVisibility,
                  ),
                ),
                const SizedBox(height: 20),
                _SignInButton(),
                // TODO: add forgot password button
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
                const SizedBox(height: 20),
                Text(
                  'Or sign in with:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.kBlackColor,
                  ),
                ),
                const SizedBox(height: 20),
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

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('signInForm_signUp_textButton'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
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
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signInForm_emailInput_textField'),
          onChanged: (email) => context.read<SignInCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: 
              state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final bool obscurePassword;
  final IconData iconPassword;
  final VoidCallback togglePasswordVisibility;

  const _PasswordInput({
    required this.obscurePassword,
    required this.iconPassword,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signInForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignInCubit>().passwordChanged(password),
          obscureText: obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
            suffixIcon: IconButton(
              icon: Icon(iconPassword),
              onPressed: togglePasswordVisibility,
            ),
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          )
          : Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.kPrimaryColor
              ),
              child: TextButton(
                onPressed: state.isValid
                  ? () => context.read<SignInCubit>().signInWithCredentials()
                  : null,
                child: Text(
                  'Sign In',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.kWhiteColor,
                    fontSize: 18,
                  ),
                ),
              ),
            );
      },
    );
  }
}

// TODO: Forgot password button
