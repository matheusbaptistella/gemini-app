import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/data/models/auth/sign_in_user_req.dart';
import 'package:gemini_app/presentation/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:gemini_app/presentation/auth/widgets/my_input_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
	bool signInRequired = false;
	IconData iconPassword = Icons.visibility;
	bool obscurePassword = true;
	String? _errorMsg;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if(state is SignInSuccess) {
					setState(() {
					  signInRequired = false;
					});
				} else if(state is SignInProcess) {
					setState(() {
					  signInRequired = true;
					});
				} else if(state is SignInFailure) {
					setState(() {
					  signInRequired = false;
						_errorMsg = 'Invalid email or password';
					});
				}
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MyInputForm(
                controller: emailController,
                labelText: 'Email',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: MyInputForm(
                controller: passwordController,
                labelText: 'Password',
                obscureText: obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                errorMsg: _errorMsg,
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Please fill in this field';
                  } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(val)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                      if(obscurePassword) {
                        iconPassword = Icons.visibility;
                      } else {
                        iconPassword = Icons.visibility_off;
                      }
                    });
                  },
                  icon: Icon(iconPassword),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            signInRequired
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<SignInBloc>().add(
                        SignInRequired(
                          SignInUserReq(
                            email: emailController.text,
                            password: passwordController.text
                          ),
                        )
                      );
                    }
                  },
                  child: Text(
                    'Sign In',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.kWhiteColor,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
          ]
        ),
      ),
    );
  }
}