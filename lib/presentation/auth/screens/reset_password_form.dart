import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/auth/cubits/reset_password/reset_password_cubit.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  bool resetPasswordAttempted = false;

  void didAttemptToResetPassword() {
    setState(() {
      resetPasswordAttempted = !resetPasswordAttempted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content:
                    Text('Password reset successful. Please check your email.'),
              ),
            );
          Navigator.of(context).pop();
        } else if (resetPasswordAttempted && state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Reset Password Failure'),
              ),
            );
          didAttemptToResetPassword();
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
                    Text(
                      'Forgot password',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'We’ll send an email with a link to reset the password.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _EmailInput(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _ResetPasswordButton(
                          didAttemptToResetPassword: didAttemptToResetPassword),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _SignInButton(),
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

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('resetPasswordForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<ResetPasswordCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextFieldColor,
                ),
            helperText: '',
            errorText:
                state.email.displayError != null ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _ResetPasswordButton extends StatelessWidget {
  final VoidCallback didAttemptToResetPassword;

  const _ResetPasswordButton({
    required this.didAttemptToResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
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
                  key: const Key('resetPasswordForm_resetPassword_textButton'),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.kPrimaryColor,
                    // padding: EdgeInsets.symmetric(
                    //   vertical: MediaQuery.of(context).size.height * 0.02,
                    //   horizontal: MediaQuery.of(context).size.width * 0.35,
                    // ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: state.isValid
                      ? () {
                          context
                              .read<ResetPasswordCubit>()
                              .resetPasswordWIthEmail();
                          didAttemptToResetPassword();
                        }
                      : null,
                  child: Text(
                    'Send',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.kWhiteColor,
                          fontSize: 18,
                        ),
                  ),
                ),
              ),
      );
    });
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('resetPasswordForm_signIn_textButton'),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Go back',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
              decoration: TextDecoration.underline,
              decorationThickness: 1,
            ),
      ),
    );
  }
}
