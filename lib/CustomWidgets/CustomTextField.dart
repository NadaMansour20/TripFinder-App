import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.isPasswordField = false,
    this.suffixIcon,
    this.isObscure = false,
    this.onSuffixIconTap,
  });

  final String? hintText;
  final bool isPasswordField;
  final bool isObscure;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixIconTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextField(
        obscureText: isPasswordField ? isObscure : false,
        decoration: InputDecoration(
          labelText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color:  Color(0xFFBA68C8),
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFBA68C8),
            ),
          ),
          suffixIcon: isPasswordField
              ? IconButton(
            icon: suffixIcon ?? Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
            onPressed: onSuffixIconTap,
          )
              : null,
        ),
      ),
    );
  }
}
