import 'dart:developer';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  final file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return file.path;
  }
  log('No image selected');
}
