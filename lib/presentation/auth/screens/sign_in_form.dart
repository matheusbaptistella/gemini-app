import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/auth/cubits/sign_in/sign_in_cubit.dart';
import 'package:gemini_app/presentation/auth/screens/reset_password.dart';
import 'package:gemini_app/presentation/auth/screens/sign_up.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool obscurePassword = true;
  IconData iconPassword = Icons.visibility;
  bool signInAttempted = false;

  void togglePasswordVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
      iconPassword = obscurePassword ? Icons.visibility : Icons.visibility_off;
    });
  }

  void didAttemptToSignIn() {
    setState(() {
      signInAttempted = !signInAttempted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInCubit, SignInState>(
      listener: (context, state) {
        if (signInAttempted && state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
          didAttemptToSignIn();
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                    _EmailInput(),
                    _PasswordInput(
                      obscurePassword: obscurePassword,
                      iconPassword: iconPassword,
                      togglePasswordVisibility: togglePasswordVisibility,
                    ),
                    Row(
                      children: [
                        _ForgotPasswordButton(),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: _SignInButton(
                        didAttemptToSignIn: didAttemptToSignIn,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Or sign in with:',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.kBlackColor,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _SignInWithGoogleButton(
                      didAttemptToSignIn: didAttemptToSignIn,
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
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextFieldColor,
                ),
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
  final VoidCallback didAttemptToSignIn;

  const _SignInButton({
    required this.didAttemptToSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
      return Center(
        child: state.status.isInProgress
            ? const CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              )
            : SizedBox(
                height: 50,
                width: 400,
                child: TextButton(
                  key: const Key('signInForm_signIn_textButton'),
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
                              .read<SignInCubit>()
                              .signInWithEmailAndPassword();
                          didAttemptToSignIn();
                        }
                      : null,
                  child: Text(
                    'Sign In',
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

class _ForgotPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('signInForm_forgotPassword_textButton'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen(),
          ),
        );
      },
      child: Text(
        'Forgot password?',
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 18,
              decoration: TextDecoration.underline,
              decorationThickness: 1,
            ),
      ),
    );
  }
}

class _SignInWithGoogleButton extends StatelessWidget {
  final VoidCallback didAttemptToSignIn;

  const _SignInWithGoogleButton({
    required this.didAttemptToSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 60,
          width: 160,
          child: TextButton(
            key: const Key('signInForm_signInGoogle_textButton'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              // padding: EdgeInsets.symmetric(
              //   vertical: MediaQuery.of(context).size.height * 0.015, // Adjusted padding for better fit
              //   horizontal: MediaQuery.of(context).size.width * 0.1, // Adjusted horizontal padding
              // ),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              context.read<SignInCubit>().signInWithGoogle();
              didAttemptToSignIn();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/images/google.png'),
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 5),
                Text(
                  'Google',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize:
                            20, // Overriding the size to match the previous one
                      ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
