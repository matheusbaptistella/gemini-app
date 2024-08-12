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
  child: LayoutBuilder(
    builder: (context, constraints) {
      // Check the width constraint
      bool isWideScreen = constraints.maxWidth > 600;

      return Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.white,
                                ),
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
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
          // BedTime <image> positioned based on screen width
          Positioned(
            top: 0,
            left: isWideScreen ? 0 : null,
            right: isWideScreen ? null : 0,
            child: Align(
              alignment: isWideScreen
                  ? Alignment.topLeft
                  : Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0), // Optional padding
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 8),
                    Image.asset(
                      'assets/images/logo.png', // Replace with your image path
                      width: 170,
                      height: 170,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'BedTime',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.white,
                        fontSize: 60
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  ),
)

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
              decorationColor: AppColors.kPrimaryColor,
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
          style: const TextStyle(
            color: Colors.white, // Change this to your desired text color
          ),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
            helperText: '',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Colors.white), // Change this to your desired border color
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors
                      .white), // Change this to your desired border color when focused
            ),
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
          style: const TextStyle(
            color: Colors.white, // Change this to your desired text color
          ),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
            helperText: '',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color:
                      Colors.white), // Change this to your desired border color
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors
                      .white), // Change this to your desired border color when focused
            ),
            errorText:
                state.password.displayError != null ? 'invalid password' : null,
            suffixIcon: IconButton(
              icon: Icon(iconPassword),
              onPressed: togglePasswordVisibility,
              color: Colors.white,
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
                          color: AppColors.kLightGreyColor,
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
              decorationColor: AppColors.kPrimaryColor,
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
                        fontSize: 20,
                        color: AppColors.kLightGreyColor,
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
