import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  /// Pick Image from a source
  /// @crop : if true the image is cropped using maxWidth
  Future<File> pickImage(ImageSource source, bool crop, double? maxWidth) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source, maxWidth: crop ? maxWidth : null);
    final file = File(image!.path);
    return file;
  }

  /// Crop the image from a file
  Future<File?> cropImage(File file) async {
    final imageCropped = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
            ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    return imageCropped != null ? File(imageCropped.path) : null;
  }

  /// Text OCR from an image using path
  Future<String> textOcr(String path) async {
    String content = "";
    final inputImage = InputImage.fromFilePath(path);
    final textRecognizer = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine textLine in block.lines) {
        for (TextElement textElement in textLine.elements) {
          content += " ${textElement.text}";
        }
        content += '\n';
      }
    }
    return content;
  }

  /// Faces detect from an image using path
  Future<List<Face>> faceDetector(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final faceDetector = GoogleMlKit.vision.faceDetector();
    List<Face> faces = await faceDetector.processImage(inputImage);
    return faces;
  }
}
