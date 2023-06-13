import 'dart:typed_data';

import 'package:automobile_management/function/time_date_function.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class Storagemethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  int uuid = TimeStamp.timestamp;
  String imageId = const Uuid().v4();
  Future<String> uploadtostorage(
      String collection, String createrid, Uint8List file) async {
    Reference ref =
        _storage.ref().child(collection).child(createrid).child(imageId);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}
