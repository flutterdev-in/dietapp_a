import 'dart:io';

import 'package:dietapp_a/Google%20Drive/drive.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerW extends StatelessWidget {
  const ImagePickerW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        // await DriveService().upload();

        final ImagePicker _picker = ImagePicker();
        final XFile? image =
            await _picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          await DriveService().upload(File(image.path));
        }
      },
      child: const Text("Pick image"),
    );
  }
}
