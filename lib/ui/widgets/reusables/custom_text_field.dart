import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.labelText,
    required this.validator,
    required this.controller,
    this.isObscureText = false,
    this.iconCallBack,
    this.iconData,
    this.charcterType
  });

  final String? labelText;
  final String? Function(String?) validator;
  final TextEditingController controller;
  final bool isObscureText;
  final VoidCallback? iconCallBack;
  final IconData? iconData;
  final String? charcterType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscuringCharacter: (charcterType != null && charcterType!.length == 1)
          ? charcterType!
          : '•',
      maxLines: 1,
      obscureText: isObscureText,
      decoration: InputDecoration(
        suffixIcon: IconButton(onPressed: iconCallBack, icon: Icon(iconData)),
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }
}
