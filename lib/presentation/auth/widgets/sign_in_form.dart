import 'package:flutter/material.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildInputForm('Email', false),
        buildInputForm('Password', true),
      ],
    );
  }

  Padding buildInputForm(String label, bool pass) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        obscureText: pass ? _isObscure : false,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: AppColors.kTextFieldColor
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.kPrimaryColor),
          ),
          suffixIcon: pass
            ? IconButton(
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
              icon: _isObscure
                ? const Icon(
                  Icons.visibility_off,
                  color: AppColors.kTextFieldColor,
                )
              : const Icon(
                  Icons.visibility,
                  color: AppColors.kPrimaryColor
              ),
            )
          : null
        ),
      ),
    );
  }
}