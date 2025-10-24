import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:fancy_snackbar/fancy_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/Logic/AuthCubit/auth_cubit.dart';
import 'package:todo_app/Logic/AuthCubit/auth_state.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/views/login%20and%20signUp/components/animated_back_ground.dart';
import 'package:todo_app/views/login%20and%20signUp/components/custom_form_text_field.dart';
import 'package:todo_app/views/login%20and%20signUp/components/custom_text_button.dart';
import 'package:todo_app/views/login%20and%20signUp/components/image_source_picker.dart';
import 'package:todo_app/views/login%20and%20signUp/components/profile_image.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController job = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();
  File? selectedImage;
  bool isImagePicked = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userName.dispose();
    job.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.go('/'); // ✅ navigate after signup
          FancySnackbar.showSnackbar(
            context,
            snackBarType: FancySnackBarType.success,
            message: 'User has been added successfully',
            title: 'Success',
          );
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

          child: Stack(
            children: [
              const AnimatedGradientBackground(),
              Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset:
                    true, // ✅ allow resize when keyboard opens
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final isTablet = constraints.maxWidth > 600;
                        final boxWidth = isTablet ? 400.0 : size.width * 0.85;

                        return Center(
                          child: SingleChildScrollView(
                            // ✅ makes screen scrollable when keyboard pops
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom + 30,
                            ),
                            child: Container(
                              width: boxWidth,
                              padding: EdgeInsets.all(isTablet ? 32 : 20),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: .1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        final pickedImage =
                                            await ImageSourcePicker.pickImage(
                                              context,
                                            );

                                        if (pickedImage != null) {
                                          isImagePicked = true;
                                          setState(() {
                                            selectedImage = File(
                                              pickedImage.path,
                                            );
                                            log(pickedImage.path);
                                            isImagePicked = true;
                                          });
                                        }
                                      },
                                      child: ProfileImage(
                                        isImageSelected: isImagePicked,
                                        image: selectedImage,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "SignUp to continue",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "UserName is required";
                                        }
                                        return null;
                                      },
                                      controller: userName,
                                      hintText: "UserName",
                                      prefixIcon: Icons.face,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Job Title is required";
                                        }
                                        return null;
                                      },
                                      controller: job,
                                      hintText: "Job Title",
                                      prefixIcon: Icons.work,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Email is required";
                                        }
                                        if (!value.contains('@')) {
                                          return "Enter a valid email";
                                        }
                                        return null;
                                      },
                                      controller: emailController,
                                      hintText: "Email",
                                      prefixIcon: Icons.email,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password is required";
                                        }
                                        return null;
                                      },
                                      controller: passwordController,
                                      hintText: "Password",
                                      prefixIcon: Icons.lock,
                                      isPassword: true,
                                    ),
                                    const SizedBox(height: 24),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white
                                            .withValues(alpha: 0.3),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 60,
                                          vertical: 14,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          context
                                              .read<AuthCubit>()
                                              .registerUser(
                                                UserModel(
                                                  password:
                                                      passwordController.text,
                                                  userEmail:
                                                      emailController.text,
                                                  userJob: job.text,
                                                  userName: userName.text,
                                                  userProfilePhotoPath:
                                                      selectedImage?.path,
                                                ),
                                              );
                                        }
                                      },
                                      child: const Text("SignUp"),
                                    ),
                                    16.h,
                                    CustomTextButton(
                                      navigateTo: '/',
                                      isForLogin: true,
                                      text: ' Login',
                                    ),
                                    8.h,
                                    Text(
                                      state is AuthFieldState
                                          ? state.errorMas
                                          : '',
                                      style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
