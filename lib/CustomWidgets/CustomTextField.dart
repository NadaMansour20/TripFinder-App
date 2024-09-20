import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({  //شيلت ال const
    super.key,
    this.hintText,
    this.isPasswordField = false,
    this.suffixIcon,
    this.isObscure = false,
    this.onSuffixIconTap,
    this.onChanged
  });

  final String? hintText;
  final bool isPasswordField;
  final bool isObscure;
  final Icon? suffixIcon;
  final VoidCallback? onSuffixIconTap;
  Function(String)? onChanged;//
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextFormField(
        validator: (data){
          if(data!.isEmpty){
          return 'field is required';
          }

        },
       onChanged:onChanged ,//
        obscureText: isPasswordField ? isObscure : false,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFFFFC1E3), // لون وردي فاتح
            ),
          ),
          suffixIcon: isPasswordField
              ? IconButton(
            icon: suffixIcon ??
                Icon(
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
