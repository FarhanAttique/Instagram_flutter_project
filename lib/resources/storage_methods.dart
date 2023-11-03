import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Storagemethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadimg(
      String childName, Uint8List file, bool isPost) async {
    String contentType =
        'image/jpeg'; // Change this based on the image file type

    // You can determine the content type based on the file type
    // For example, if it's a PNG image, you can set contentType to 'image/png'.

    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    // Set the content type metadata for the file
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');

    UploadTask upload = ref.putData(file, metadata);
    TaskSnapshot snap = await upload;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
