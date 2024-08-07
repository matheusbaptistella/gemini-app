import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/auth/cubits/sign_up/sign_up_cubit.dart';
import 'package:gemini_app/presentation/auth/widgets/checkbox.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obscurePassword = true;
  IconData iconPassword = Icons.visibility;
  bool signUpAttempted = false;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
      iconPassword = obscurePassword ? Icons.visibility : Icons.visibility_off;
    });
  }

  void didAttemptToSignUp() {
    setState(() {
      signUpAttempted = !signUpAttempted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pop();
        } else if (signUpAttempted && state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
          didAttemptToSignUp();
        }
      },
      child: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      'Create Account',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          'Already a member?',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 5),
                        _SignInButton(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _NameInput(),
                    ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _ConfirmPasswordInput(
                        obscurePassword: obscurePassword,
                        iconPassword: iconPassword,
                        togglePasswordVisibility: togglePasswordVisibility,
                      ),
                    ),
                    const CheckBox('Agree to terms and conditions.'),
                    const SizedBox(height: 40),
                    _SignUpButton(
                      didAttemptToSignUp: didAttemptToSignUp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('signUpForm_signIn_textButton'),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Sign In',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
              decoration: TextDecoration.underline,
              decorationThickness: 1,
            ),
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_nameInput_textField'),
          onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextFieldColor,
                ),
            helperText: '',
            errorText: state.name.displayError != null ? 'Invalid name' : null,
          ),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextFieldColor,
                ),
            helperText: '',
            errorText:
                state.email.displayError != null ? 'Invalid email' : null,
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextFieldColor,
                ),
            helperText: '',
            errorText:
                state.password.displayError != null ? 'Invalid password' : null,
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

class _ConfirmPasswordInput extends StatelessWidget {
  final bool obscurePassword;
  final IconData iconPassword;
  final VoidCallback togglePasswordVisibility;

  const _ConfirmPasswordInput({
    required this.obscurePassword,
    required this.iconPassword,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          obscureText: obscurePassword,
          decoration: InputDecoration(
            hintText: 'Confirm password',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextFieldColor,
                ),
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
                ? 'Passwords do not match'
                : null,
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

class _SignUpButton extends StatelessWidget {
  final VoidCallback didAttemptToSignUp;

  const _SignUpButton({
    required this.didAttemptToSignUp,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Center(
          child: state.status.isInProgress
              ? const CircularProgressIndicator(
                  color: AppColors.kPrimaryColor,
                )
              : SizedBox(
                  height: 50,
                  width: 400,
                  child: TextButton(
                    key: const Key('signUpForm_signUp_textButton'),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.kPrimaryColor,
                      // padding: EdgeInsets.symmetric(
                      //   vertical: 10,
                      //   horizontal: 20,
                      // ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: state.isValid
                        ? () {
                            context
                                .read<SignUpCubit>()
                                .signUpWithEmailAndPassword();
                            didAttemptToSignUp();
                          }
                        : null,
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.kWhiteColor,
                            fontSize: 18,
                          ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
