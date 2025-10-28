import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/Logic/AuthCubit/auth_cubit.dart';
import 'package:todo_app/Logic/AuthCubit/auth_state.dart';
import 'package:todo_app/data/isar_data_base_of_users.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/views/login and signUp/components/animated_back_ground.dart';
import 'package:todo_app/views/login and signUp/components/custom_form_text_field.dart';
import 'package:todo_app/views/login and signUp/components/image_source_picker.dart';
import 'package:todo_app/views/login and signUp/components/profile_image.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  File? selectedImage;
  bool isImagePicked = false;
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthCubit>().state;
    if (state is AuthSuccessState) {
      currentUser = state.user;
      userNameController.text = state.user.userName;
      jobController.text = state.user.userJob;
      passwordController.text = state.user.password;
      if (state.user.userProfilePhotoPath != null) {
        selectedImage = File(state.user.userProfilePhotoPath!);
        isImagePicked = true;
      }
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    jobController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!formKey.currentState!.validate()) return;
    final user = currentUser;
    if (user == null) return;

    // Fetch DB user so we preserve Isar id for update
    final dbUser =
        await IsarDataBaseOfUsers.getUserByUserId(user.userId) ?? user;

    dbUser
      ..userName = userNameController.text.trim()
      ..userJob = jobController.text.trim()
      ..password = passwordController.text
      ..userProfilePhotoPath = selectedImage?.path ?? user.userProfilePhotoPath;

    // Update via AuthCubit (handles DB + SharedPrefs)
    await context.read<AuthCubit>().updateUser(dbUser);

    if (mounted) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (currentUser == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            children: [
              const AnimatedGradientBackground(),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text('Update Profile'),
                ),
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
                                        final picked =
                                            await ImageSourcePicker.pickImage(
                                              context,
                                            );
                                        if (picked != null) {
                                          setState(() {
                                            selectedImage = picked;
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
                                      "Update your information",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    CustomTextFormField(
                                      controller: userNameController,
                                      hintText: "UserName",
                                      prefixIcon: Icons.face,
                                      validator: (value) =>
                                          (value == null || value.isEmpty)
                                          ? 'UserName is required'
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextFormField(
                                      controller: jobController,
                                      hintText: "Job Title",
                                      prefixIcon: Icons.work,
                                      validator: (value) =>
                                          (value == null || value.isEmpty)
                                          ? 'Job Title is required'
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                    CustomTextFormField(
                                      controller: passwordController,
                                      hintText: "Password",
                                      prefixIcon: Icons.lock,
                                      isPassword: true,
                                      validator: (value) =>
                                          (value == null || value.isEmpty)
                                          ? 'Password is required'
                                          : null,
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Colors.black87,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        onPressed: _save,
                                        child: const Text('Save Changes'),
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
