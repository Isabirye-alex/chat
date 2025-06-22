import 'dart:io';

import 'package:chat_app/core/services/auth_services/login/login_screen.dart';
import 'package:chat_app/core/services/auth_services/signup/sign_up_controller.dart';
import 'package:chat_app/core/services/bindings/sign_up_bindings.dart';
import 'package:chat_app/ui/widgets/image_picker.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text_button.dart';
import 'package:chat_app/ui/widgets/reusables/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final controller = Get.put(SignUpController());

  File? image; // ✅ moved here

  void selectImage() async {
    final result = await Get.to<File>(() => const ImagePickerWidget());
    if (result != null) {
      setState(() {
        image = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
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
                        GestureDetector(
                          onTap: selectImage,
                          child: CircleAvatar(
                            foregroundColor: Colors.green,
                            radius: 50,
                            backgroundColor: Colors.purple,
                            backgroundImage: image != null
                                ? FileImage(image!)
                                : null,
                            child: image == null
                                ? const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                        10.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: CustomTextField(
                                controller: controller.firstNameController,
                                validator: (value) => controller
                                    .validateNotEmpty(value, 'First Name'),
                                labelText: 'First Name',
                                prefixIcon: Icons.person,
                              ),
                            ),
                            8.horizontalSpace,
                            Expanded(
                              flex: 5,
                              child: CustomTextField(
                                controller: controller.lastNameController,
                                validator: (value) => controller
                                    .validateNotEmpty(value, 'Last Name'),
                                labelText: 'Last Name',
                                prefixIcon: Icons.person_outline_outlined,
                              ),
                            ),
                          ],
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          prefixIcon: Icons.email,
                          controller: controller.emailController,
                          validator: (value) =>
                              controller.validateNotEmpty(value, 'Email'),
                          labelText: 'Enter your email',
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          controller: controller.usernameController,
                          validator: (value) =>
                              controller.validateNotEmpty(value, 'Username'),
                          labelText: 'Username',
                          prefixIcon: Icons.person_4_outlined,
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
                          labelText: 'Password',
                          prefixIcon: Icons.password,
                        ),
                        8.verticalSpace,
                        CustomTextField(
                          iconCallBack: () {
                            setState(() {
                              isConfirmPasswordHidden =
                                  !isConfirmPasswordHidden;
                            });
                          },
                          iconData: isConfirmPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                          charcterType: '*',
                          isObscureText: isConfirmPasswordHidden,
                          controller: controller.confirmPasswordController,
                          validator: (value) =>
                              controller.validateConfirmPassword(value),
                          labelText: 'Confirm your password',
                          prefixIcon: Icons.password,
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
                      text: 'Sign up',
                      radius: 10.r,
                      textColor: Colors.white,
                      callBack: () => controller.validateAndSubmit(),
                    ),
                  ),
                  10.verticalSpace,
                  CustomTextButton(
                    isLoading: false,
                    fontSize: 18,
                    text: 'Already have an account? Log in',
                    textColor: Colors.blue,
                    callBack: () => Get.off(
                      () => const LoginScreen(),
                      binding: SignUpBindings(),
                    ),
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
