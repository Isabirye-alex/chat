import 'package:chat_app/core/services/auth_services/login/login_controller.dart';
import 'package:chat_app/core/services/auth_services/signup/sign_up_screen.dart';
import 'package:chat_app/core/services/bindings/log_in_bindings.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text_button.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordHidden = true;
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 0.85.sh,
          width: 1.sw,
          child: Center(
            child: Container(
              margin: EdgeInsets.all(12.w),
              padding: EdgeInsets.all(8.spMax),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  35.verticalSpace,
                  CustomText(
                    fontFamily: 'Poppins',
                    text: 'Login to your account',
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                  5.verticalSpace,
                  CustomText(
                    textAlign: TextAlign.center,
                    fontFamily: 'Poppins',
                    text: 'We\'re happy to see you back!',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  5.verticalSpace,
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        CustomTextField(
                          controller: controller.usernameController,
                          validator: (value) =>
                              controller.validateNotEmpty(value, 'Email'),
                          labelText: 'Enter your Username',
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          iconCallBack: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          iconData: isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                          isObscureText: isPasswordHidden,
                          charcterType: '*',
                          controller: controller.passwordController,
                          validator: (value) =>
                              controller.validatePassword(value),
                          labelText: 'Enter Password',
                        ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Obx(
                    () => CustomTextButton(
                      isLoading: controller.isLoading.value,
                      fontSize: 24,
                      color: Colors.blue,
                      text: 'LogIn',
                      radius: 10.r,
                      textColor: Colors.white,
                      callBack: () => controller.validateAndSubmit(),
                    ),
                  ),
                  10.verticalSpace,
                  CustomTextButton(
                    isLoading: false,
                    fontSize: 18,
                    text: 'Don\'t have an account? Sign Up',
                    textColor: Colors.blue,
                    callBack: () {
                      Get.off(() => SignUpScreen(), binding: LogInBindings());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
