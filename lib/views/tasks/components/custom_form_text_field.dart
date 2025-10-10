import 'package:flutter/material.dart';
import 'package:todo_app/utils/app_str.dart';

class CustomFormTextField extends StatelessWidget {
  const CustomFormTextField({
    super.key,
    required this.controller,
    this.isForDescription = false,
    required this.onFieldSubmitted,
  });
  final TextEditingController controller;
  final bool isForDescription;
  final void Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ListTile(
        title: TextFormField(
          
          controller: controller,
          onFieldSubmitted: onFieldSubmitted,
          maxLines: !isForDescription ? 6 : null,
          cursorHeight: !isForDescription ? 60 : null,
          decoration: InputDecoration(
            prefixIcon: isForDescription
                ? Icon(Icons.bookmark_border, color: Colors.grey)
                : null,
            // border: isForDescription ? InputBorder.none : null,
            counter: Container(),
            hintText: isForDescription ? AppStr.addNote : null,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ),
    );
  }
}
