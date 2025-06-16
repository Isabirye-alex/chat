import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.text,
    required this.callBack,
    required this.isLoading,
    this.color,
    this.radius,
    this.textColor,
    required this.fontSize,
  });

  final String text;
  final VoidCallback callBack;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
      height: 40.h,
      width: 1.sw,
      child: TextButton(
        onPressed: isLoading ? null : callBack,
        child: isLoading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: CircularProgressIndicator(
                  color: textColor ?? Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
