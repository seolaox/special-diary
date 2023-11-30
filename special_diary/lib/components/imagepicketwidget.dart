import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatelessWidget {
  final ValueChanged<ImageSource> onTap;
  final XFile? imageFile;

  const ImagePickerWidget({Key? key, required this.onTap, required this.imageFile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(ImageSource.gallery);
      },
      child: Container(
        width: 350,
        height: 210,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 212, 221, 247),
          image: imageFile != null
              ? DecorationImage(
                  image: FileImage(File(imageFile!.path)),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: imageFile == null
            ? Icon(
                Icons.add_a_photo,
                size: 48,
                color: Colors.grey,
              )
            : null,
      ),
    );
  }
}
