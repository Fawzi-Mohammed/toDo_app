import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_app/views/home/components/custom_slider_drawer_body.dart';

class CustomSliderDrawer extends StatelessWidget {
  const CustomSliderDrawer({super.key, required this.widget});
  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return SliderDrawer(
      animationDuration: 1000,
      appBar: SliderAppBar(
        config: SliderAppBarConfig(
          title: Text(''),
          drawerIconSize: 30,
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.trash_fill, size: 30),
          ),
        ),
      ),
      isDraggable: false,
      slider: CustomSliderDrawerBody(),
      child: widget,
    );
  }
}
