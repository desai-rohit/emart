import 'package:ecommerse_dev_app/consts/consts.dart';

class FirestoreServices {
  // get user data
  static getUser(uid) {
    return firestore
        .collection(userCOllection)
        .where("id", isEqualTo: uid)
        .get();
  }

  static getProduct(category) {
    return firestore
        .collection(productCollection)
        .where('p_category', isEqualTo: category)
        .get();
  }

  static getsameproduct(name) {
    return firestore
        .collection(productCollection)
        .where('p_name', isEqualTo: name)
        .snapshots();
  }

  static todayDeals() {
    return firestore
        .collection(productCollection)
        .where('p_today_deals', isEqualTo: true)
        .get();
  }

  static flashSeal() {
    return firestore
        .collection(productCollection)
        .where('flash_seal', isEqualTo: true)
        .get();
  }

  static getcartproduct(uid) {
    return firestore
        .collection(cartCollection)
        .where("addedby", isEqualTo: uid)
        .snapshots();
  }

  static cartdelete(docId) {
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  // get all chat mesaage
  static getchatMessages(docid) {
    firestore
        .collection(chatsCollection)
        .doc(docid)
        .collection(messageCollection)
        .orderBy("created_on", descending: false)
        .get();
  }

  static getAllOrders() {
    return firestore
        .collection(orderCollection)
        .where('order_by', isEqualTo: currentUser!.uid)
        .get();
  }

  static getAllWishlist() {
    return firestore
        .collection(productCollection)
        .where('wishlist', arrayContains: currentUser!.uid)
        .snapshots();
  }

  static getAllMessage() {
    firestore
        .collection(chatsCollection)
        .where("formId", isEqualTo: currentUser!.uid)
        .get();
  }

  static getAllProduct() {
    return firestore.collection(productCollection).get();
  }

  static getAddAddress(uid) {
    return firestore
        .collection(addAddressCollection)
        .where("user_id", isEqualTo: uid)
        .get();
  }

  static getreview() {
    return firestore.collection(orderCollection).get();
  }

  static getsearchresult(query) {
    return firestore
        .collection(productCollection)
        .where('p_name', isGreaterThanOrEqualTo: query)
        .where('p_name', isLessThan: query + 'z')
        .get();
  }
}
