import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var quantitycount = 1.obs;
  var colorindex = 0.obs;
  var totalprice = 0.obs;
  var subcat = [];
  var colorname = "".obs;
  var reating = "0".obs;
  var addreview = [];
  var ratingavg = 0.obs;

  var isfav = false.obs;
  var islaoding = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[1].subcategory) {
      subcat.add(e);
    }
  }

  chnagecolorindex(index) {
    colorindex.value = index;
  }

  incresequantity(totalQuantity) {
    if (quantitycount.value < totalQuantity) {
      quantitycount.value++;
    }
  }

  decresequantity() {
    if (quantitycount.value > 1) {
      quantitycount.value--;
    }
  }

  calculateTotalPrice(price) {
    totalprice.value = price * quantitycount.value;
  }

  addToCart(
      {title,
      img,
      seller,
      color,
      quantity,
      tprice,
      context,
      venderId,
      price,
      productquantity,
      productId}) async {
    await firestore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "seller": seller,
      "color": color,
      "venderID": venderId,
      "quantity": quantity,
      "tprice": tprice,
      "addedby": currentUser!.uid,
      "price": price,
      "product_quantity": productquantity,
      "prodcut_id": productId
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValue(value) {
    totalprice.value = value;
    quantitycount.value = 1;
    colorindex.value = 0;
  }

  addToWishlist(docid, context) async {
    await firestore.collection(productCollection).doc(docid).set({
      "wishlist": FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(true);
    VxToast.show(context, msg: " Added To Wishlist");
  }

  removeFormWishlist(docid, context) async {
    await firestore.collection(productCollection).doc(docid).set({
      "wishlist": FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isfav(false);
  }

  checkIfFav(data) async {
    if (data["wishlist"].contains(currentUser!.uid)) {
      isfav(true);
    } else {
      isfav(false);
    }
  }

  // review({p_name, seller_id, rateing, review, username, userid,bcontext}) async {
  //   await firestore.collection(reviewCollection).doc(currentUser!.uid).set({
  //     "p_name": p_name,
  //     "seller_id": seller_id,
  //     "rateing": rateing,
  //     "review": review,
  //     "user_name": username,
  //     "user_id":userid,
  //   }).catchError((error) {
  //     VxToast.show(bcontext, msg: error.toString());
  //   });
  // }
  Future review(rateing, reviewDes, productDocId) async {
    await firestore.collection(orderCollection).doc(productDocId).set({
      "review": {"rating": rateing, "review_des": reviewDes}
      // "review": FieldValue.arrayUnion(addreview)
    }, SetOptions(merge: true));
  }

  // postreview(rateing, review) {
  //   addreview.add({"rateing": rateing, "review": review});
  // }
}
