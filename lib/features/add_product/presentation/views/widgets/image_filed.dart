import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ImageField extends StatefulWidget {
  const ImageField({
    super.key,
    required this.onFileChanged,
  });
  final ValueChanged<File?> onFileChanged;

  @override
  State<ImageField> createState() => _ImageFieldState();
}

class _ImageFieldState extends State<ImageField> {
  bool isLoading = false;
  File? fileImage;
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: GestureDetector(
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          try {
            await pickImage();
          } on Exception catch (e) {}
          setState(() {
            isLoading = false;
          });
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              child: fileImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.file(fileImage!))
                  : const Icon(
                      Icons.image_outlined,
                      size: 180,
                    ),
            ),
            Visibility(
              visible: fileImage != null,
              child: IconButton(
                  onPressed: () {
                    fileImage = null;
                    widget.onFileChanged(null);

                    setState(() {});
                  },
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.red,
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    fileImage = File(
      image!.path,
    );
    widget.onFileChanged(fileImage!);
  }
}
