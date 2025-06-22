import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialSignInButtons extends StatelessWidget {
  const SocialSignInButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        10.verticalSpace,
        Divider(thickness: 1, height: 1),
        5.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      'assets/icons/google.png',
                      fit: BoxFit.cover,
                      width: 40,
                      height: 40,
                    ),
                  ),
                  Text('Google'),
                ],
              ),
            ),
            20.horizontalSpace,
            GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  3.verticalSpace,
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'assets/icons/facebook.png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                      repeat: ImageRepeat.noRepeat,
                    ),
                  ),
                  6.verticalSpace,
                  Text('Facebook'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
