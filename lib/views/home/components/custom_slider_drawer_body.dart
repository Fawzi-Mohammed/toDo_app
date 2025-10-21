import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/models/slider_drawer_item.dart';
import 'package:todo_app/utils/app_color.dart';

class CustomSliderDrawerBody extends StatefulWidget {
  const CustomSliderDrawerBody({super.key});

  @override
  State<CustomSliderDrawerBody> createState() => _CustomSliderDrawerBodyState();
}

class _CustomSliderDrawerBodyState extends State<CustomSliderDrawerBody> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    List<SliderDrawerItem> sliderItem = [
      SliderDrawerItem(text: 'Home', iconData: CupertinoIcons.home),
      SliderDrawerItem(text: 'Profile', iconData: CupertinoIcons.person_fill),
      SliderDrawerItem(
        text: 'LogOut',
        iconData: CupertinoIcons.arrow_right_square,
      ),
      SliderDrawerItem(
        text: 'Details',
        iconData: CupertinoIcons.info_circle_fill,
      ),
    ];

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
          CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/img/profile .jpg'),
          ),
          8.h,
          Text('Fawzi Mohammed', style: textTheme.displayMedium),
          Text('Flutter Developer', style: textTheme.displaySmall),
          20.h,
          Expanded(
            child: ListView.builder(
              itemCount: sliderItem.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;

                return InkWell(
                  onTap: () {
                    if (index != selectedIndex) {
                      setState(() => selectedIndex = index);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 12.0,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.white.withValues(alpha: .2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: isSelected ? 1.2 : 1.0,
                          child: Icon(
                            sliderItem[index].iconData,
                            color: Colors.white,
                            size: 26,
                          ),
                        ),
                        10.w,
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: textTheme.titleMedium!.copyWith(
                            color: isSelected
                                ? Colors.white
                                : Colors.white.withValues(alpha: .8),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                          child: Text(sliderItem[index].text),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
