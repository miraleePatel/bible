import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShareController extends GetxController{
  late TabController tabEditImageController;

  RxInt imageIndex = (-1).obs;
  RxInt fontIndex = (0).obs;
  RxBool isArrangeSize = false.obs;
  var imageName = ''.obs;
  var imagePath = ''.obs;

  List fontList = [
    'Poppins',
    'Ultra',
    'Oswald',
    'Alike',
    'Averia Serif Libre',
    'Bad Script',
    'Baskervville',
    'Baumans',

  ];

  /// Image Picker
  Future<File> openImagePicker(ImageSource sourceData) async {
    XFile? xFile = await ImagePicker().pickImage(
      source: sourceData,
    );
    return File(xFile!.path);
  }

}