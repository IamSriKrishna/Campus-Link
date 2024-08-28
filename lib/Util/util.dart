
import 'dart:io';

import 'package:campuslink/Constrains/AssetImage.dart';
import 'package:campuslink/Constrains/FontFamily.dart';
import 'package:campuslink/Constrains/ThemeColor.dart';
import 'package:campuslink/Util/Duration.dart';
import 'package:file_picker/file_picker.dart';

// To access Fontfamily
RobotoFontFamily robotoFontFamily = RobotoFontFamily();


// To access App Theme Color
ThemeColor themeColor = ThemeColor();

// To access App assets images
AssetImage assetImage = AssetImage();

// To access App Duration
AppDuration duration = AppDuration();

String uri ="http://65.2.137.77:3000";

String halfuri ="65.2.137.77:3000";

String kcgSKCHAt = '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';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return images;
}