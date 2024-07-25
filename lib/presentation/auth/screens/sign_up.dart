import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/data/models/auth/sign_up_user_req.dart';
import 'package:gemini_app/presentation/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:gemini_app/presentation/auth/widgets/auth_options.dart';
import 'package:gemini_app/presentation/auth/widgets/checkbox.dart';
import 'package:gemini_app/presentation/auth/widgets/my_input_form.dart';
import 'package:gemini_app/presentation/auth/widgets/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signUpRequired = false;
  IconData iconPassword = Icons.visibility;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if(state is SignUpSuccess) {
					setState(() {
					  signUpRequired = false;
					});
				} else if(state is SignUpProcess) {
					setState(() {
					  signUpRequired = true;
					});
				} else if(state is SignUpFailure) {
					return;
				} 
      },
      child: Scaffold(
        body: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                        'Already a member?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          // Switch to sign in screen
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
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: MyInputForm(
                      controller: nameController,
                      hintText: 'Name',
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      validator: (val) {
                        if(val!.isEmpty) {
                          return 'Please fill in this field';													
                        } else if(val.length > 30) {
                          return 'Name too long';
                        }
                        return null;
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: MyInputForm(
                      controller: emailController,
                      labelText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: MyInputForm(
                      controller: passwordController,
                      labelText: 'Confirm Password',
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
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
                  const CheckBox('Agree to terms and conditions.'),
                  const SizedBox(
                    height: 20,
                  ),
                  const CheckBox('I have at least 18 years old.'),
                  const SizedBox(
                    height: 20,
                  ),
                  signUpRequired
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
                          context.read<SignUpBloc>().add(
                            SignUpRequired(
                              SignUpUserReq(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text
                              ),
                            )
                          );
                        }
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.kWhiteColor,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Or sign up with:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColors.kBlackColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AuthOptions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
