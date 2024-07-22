import 'package:flutter/material.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';

class MyInputForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
	final TextInputType keyboardType;
	final Widget? suffixIcon;
	// final VoidCallback? onTap;
	final String? Function(String?)? validator;
	// final FocusNode? focusNode;
	final String? errorMsg;
	final String? Function(String?)? onChanged;

	const MyInputForm({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
		required this.keyboardType,
		this.suffixIcon,
		// this.onTap,
		this.validator,
		// this.focusNode,
		this.errorMsg,
		this.onChanged
  });

  @override
	Widget build(BuildContext context) {
		return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
			keyboardType: keyboardType,
			// focusNode: focusNode,
			// onTap: onTap,
			textInputAction: TextInputAction.next,
			onChanged: onChanged,
      decoration: InputDecoration(
				suffixIcon: suffixIcon,
				// enabledBorder: OutlineInputBorder(
				// 	borderRadius: BorderRadius.circular(10),
				// 	borderSide: const BorderSide(color: Colors.transparent),
				// ),
				focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.kPrimaryColor)
        ),
				// fillColor: Colors.grey.shade200,
				// filled: true,
				hintText: hintText,
				hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.kTextFieldColor,
        ),
				errorText: errorMsg,
			),
    );
	}
}