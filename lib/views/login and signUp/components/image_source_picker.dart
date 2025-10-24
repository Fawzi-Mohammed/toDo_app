import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourcePicker {
  static final ImagePicker _picker = ImagePicker();

  /// Shows a bottom sheet that lets the user pick between Camera and Gallery.
  /// Returns a [File] of the selected image or null if canceled.
  static Future<File?> pickImage(BuildContext context) async {
    return showModalBottomSheet<File?>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              // Only show camera option on iOS and Android
              if (Platform.isAndroid || Platform.isIOS)
                ListTile(
                  leading: const Icon(
                    Icons.camera_alt,
                    color: Colors.blueAccent,
                  ),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    final picked = await _picker.pickImage(
                      source: ImageSource.camera,
                    );
                    Navigator.pop(
                      context,
                      picked != null ? File(picked.path) : null,
                    );
                  },
                ),

              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Colors.deepPurpleAccent,
                ),
                title: const Text('Choose from gallery'),
                onTap: () async {
                  final picked = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  Navigator.pop(
                    context,
                    picked != null ? File(picked.path) : null,
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.close, color: Colors.redAccent),
                title: const Text('Cancel'),
                onTap: () => Navigator.pop(context, null),
              ),
            ],
          ),
        );
      },
    );
  }
}
