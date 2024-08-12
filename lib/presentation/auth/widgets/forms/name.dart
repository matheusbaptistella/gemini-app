import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  const Name.dirty([super.value = '']) : super.dirty();

  @override
  NameValidationError? validator(String? value) {
    if (value != null && value.length > 32) {
      return NameValidationError.invalid;
    }
    return null;
  }
}
