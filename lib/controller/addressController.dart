import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class addressControl extends GetxController {
  updateAddress(
      {addresscontroller,
      citycontroller,
      statecontroller,
      postalCodecontroller,
      phonecontroller,
      emailcontroller}) async {
    var address =
        firestore.collection(addAddressCollection).doc(currentUser!.uid);
    await address.set({
      "name": currentUser!.displayName,
      "address": addresscontroller,
      "city": citycontroller,
      "state": statecontroller,
      "postal_code": postalCodecontroller,
      "phone": phonecontroller,
      "email": emailcontroller
    }, SetOptions(merge: true));
  }
}
