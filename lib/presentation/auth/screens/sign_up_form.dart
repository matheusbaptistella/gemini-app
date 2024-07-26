import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/auth/cubits/sign_up_cubit/sign_up_cubit.dart';
import 'package:gemini_app/presentation/auth/widgets/auth_options.dart';
import 'package:gemini_app/presentation/auth/widgets/checkbox.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
    return BlocListener<SignUpCubit, SignUpState>(
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
                const SizedBox(height: 20),
                const CheckBox('Agree to terms and conditions.'),
                const SizedBox(height: 20),
                _SignUpButton(),
                const SizedBox(height: 20),
                Text(
                  'Or sign up with:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.kBlackColor
                  ),
                ),
                const SizedBox(height: 20),
                const AuthOptions(),
              ],
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
            labelText: 'Name',
            helperText: '',
            errorText: 
              state.name.displayError != null ? 'invalid name' : null,
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
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
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm password',
            helperText: '',
            errorText: state.confirmedPassword.displayError != null
              ? 'passwords do not match'
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
                  ? () => context.read<SignUpCubit>().signUpWithCredentials()
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
