import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/Logic/AuthCubit/auth_cubit.dart';
import 'package:todo_app/Logic/AuthCubit/auth_state.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/models/slider_drawer_item.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/views/home/components/slider_drawer_item_widget.dart';
import 'package:todo_app/views/login%20and%20signUp/components/profile_image.dart';

class CustomSliderDrawerBody extends StatefulWidget {
  const CustomSliderDrawerBody({super.key});

  @override
  State<CustomSliderDrawerBody> createState() => _CustomSliderDrawerBodyState();
}

class _CustomSliderDrawerBodyState extends State<CustomSliderDrawerBody> {
  UserModel? userModel;
  int selectedIndex = 0;

  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).checkIfLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    List<SliderDrawerItemModel> sliderItem = [
      SliderDrawerItemModel(text: 'Home', iconData: CupertinoIcons.home),
      SliderDrawerItemModel(
        text: 'Profile',
        iconData: CupertinoIcons.person_fill,
      ),
      SliderDrawerItemModel(
        text: 'LogOut',
        iconData: CupertinoIcons.arrow_right_square,
      ),
      SliderDrawerItemModel(
        text: 'Details',
        iconData: CupertinoIcons.info_circle_fill,
      ),
    ];

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          setState(() => userModel = state.user);
        }
      },
      builder: (context, state) {
        if (userModel == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 90.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppColor.gradientColor,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                userModel!.userProfilePhotoPath == null
                    ? ProfileImage()
                    : ProfileImage(
                        isImageSelected: true,
                        image: File(userModel!.userProfilePhotoPath!),
                      ),
                8.h,
                Text(userModel!.userName, style: textTheme.displayMedium),
                Text(userModel!.userJob, style: textTheme.displaySmall),
                20.h,
                Expanded(
                  child: ListView.builder(
                    itemCount: sliderItem.length,
                    itemBuilder: (context, index) {
                      final isSelected = index == selectedIndex;
                      final item = sliderItem[index];

                      return SliderDrawerItemWidget(
                        icon: item.iconData,
                        text: item.text,
                        isSelected: isSelected,
                        onTap: () {
                          if (index != selectedIndex) {
                            setState(() => selectedIndex = index);
                            if (item.text == 'LogOut') {
                              context.go('/');
                              context.read<AuthCubit>().LogOut();
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
