import 'package:formz/formz.dart';

enum PasswordValidationError { invalid }

class Password extends FormzInput<String, PasswordValidationError>
    with FormzInputErrorCacheMixin {
  Password.pure() : super.pure('');

  Password.dirty([super.value = '']) : super.dirty();

  static final _passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$');

  @override
  PasswordValidationError? validator(String? value) {
    return (_passwordRegExp.hasMatch(value ?? '')
        ? null
        : PasswordValidationError.invalid);
  }
}
