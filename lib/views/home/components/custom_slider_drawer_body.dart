import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/extensions/space_exe.dart';
import 'package:todo_app/models/slider_drawer_item.dart';
import 'package:todo_app/utils/app_color.dart';

class CustomSliderDrawerBody extends StatelessWidget {
  const CustomSliderDrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    List<SliderDrawerItem> sliderItem = [
      SliderDrawerItem(text: 'Home', iconData: CupertinoIcons.home),
      SliderDrawerItem(text: 'Profile', iconData: CupertinoIcons.person_fill),
      SliderDrawerItem(text: 'Settings', iconData: CupertinoIcons.settings),
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
            backgroundImage: AssetImage('assets/img/profile .jpg'),
          ),
          8.h,
          Text('Fawzi Mohammed', style: textTheme.displayMedium),
          Text('Flutter Developer', style: textTheme.displaySmall),
          20.h,
          Expanded(
            child: ListView.builder(
              itemCount: sliderItem.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(
                        sliderItem[index].iconData,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(sliderItem[index].text),
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
