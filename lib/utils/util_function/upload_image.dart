

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/models/universal_data.dart';

Future<UniversalData> imageUploader(XFile xFile) async {
  String downloadUrl = "";
  try {
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("images/${xFile.name}");
    await imageRef.putFile(File(xFile.path));
    downloadUrl = await imageRef.getDownloadURL();
  debugPrint('STORAGE ISHLADI');
    return UniversalData(data: downloadUrl);
  } catch (error) {
    debugPrint('STORAGE ISHLAMADI');
    return UniversalData(error: error.toString());
  }}