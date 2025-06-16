import 'package:chat_app/core/services/auth_services/login/login_screen.dart';
import 'package:chat_app/core/services/auth_services/signup/sign_up_controller.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text_button.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
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
                    text: 'Create your account',
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                  5.verticalSpace,
                  CustomText(
                    textAlign: TextAlign.center,
                    fontFamily: 'Poppins',
                    text: 'We\'re happy to see you Join us!',
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  5.verticalSpace,
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CustomTextField(
                                controller: controller.firstNameController,
                                validator: (value) =>
                                  controller.validateNotEmpty(
                                    value,
                                    'First Name',
                                  ),
                                labelText: 'Enter your firstname',
                              ),
                            ),
                            8.horizontalSpace,
                            Expanded(
                              flex: 5,
                              child: CustomTextField(
                                controller: controller.lastNameController,
                                validator: (value)=>controller.validateNotEmpty(value, 'Last Name'),
                                labelText: 'Enter your Lastname',
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          controller: controller.emailController,
                          validator: (value)=>controller.validateNotEmpty(value, 'Email'),
                          labelText: 'Enter your email'),
                        8.verticalSpace,
                        CustomTextField(
                          controller: controller.usernameController,
                          validator: (value)=>controller.validateNotEmpty(value, 'Username'),
                          labelText: 'Enter your username'),
                        8.verticalSpace,
                        CustomTextField(
                          controller: controller.passwordController,
                          validator: (value)=>controller.validatePassword(value),
                          labelText: 'Enter your password'),
                        8.verticalSpace,
                        CustomTextField(
                          controller: controller.confirmPasswordController,
                          validator:(value)=> controller.validateConfirmPassword(value),
                          labelText: 'Confirm your password'),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Obx(()=>CustomTextButton(
                    isLoading: controller.isLoading.value,
                      fontSize: 24,
                      color: Colors.blue,
                      text: 'Sign up',
                      radius: 10.r,
                      textColor: Colors.white,
                      callBack: () =>controller.validateAndSubmit(),
                    ),
                  ),
                  10.verticalSpace,
                  CustomTextButton(
                    isLoading:  false,
                    fontSize: 18,
                    text: 'Already have an account? Log in',
                    textColor: Colors.blue,
                    callBack: () 
                      =>Get.to(()=>LoginScreen())
                    ,
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
