import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  var profileimagepath = ''.obs;
  var profileimagelink = '';
  var isloading = false.obs;

  var namecontroller = TextEditingController();
  var newpasswordcontroller = TextEditingController();
  var oldpasswordcontroller = TextEditingController();

  chnageImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileimagepath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var FileName = File(profileimagepath.value);
    var destination = 'images/${currentUser!.uid}/filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileimagepath.value));
    profileimagelink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imageurl}) async {
    var store = firestore.collection(userCOllection).doc(currentUser!.uid);
    await store.set({'name': name, "password": password, "imageurl": imageurl},
        SetOptions(merge: true));
    isloading(true);
  }

  chnageAuthPassword(email, password, newpassword) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((erroe) {});
  }
}
