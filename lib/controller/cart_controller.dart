import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalcart = 0.obs;
  var quantitycount = 1.obs;
  var totalprice = 0.obs;
  var islaoding = false.obs;

  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalcodeController = TextEditingController();
  var phoneController = TextEditingController();

  var paymentindex = 0.obs;
  late dynamic productSnapshot;
  late dynamic addressdeails;
  var products = [];

  var placeingOrder = false.obs;

  calculat(data) {
    totalcart.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalcart.value =
          totalcart.value + int.parse(data[i]["tprice"].toString());
    }
  }

  chnagePaymetIndex(index) {
    paymentindex.value = index;
  }

  addAddress() async {
    await firestore.collection(addAddressCollection).doc(currentUser!.uid).set({
      "name": nameController.text,
      "address": addressController.text,
      "city": cityController.text,
      "state": stateController.text,
      "postal_code": postalcodeController.text,
      "phone": phoneController.text,
      "email": currentUser!.email,
      "user_id": currentUser!.uid,
    });
  }

  getaddress() async {}

  Future<void> placeMyOrder(
      {required orderpayment,
      //required totalamount,
      data,
      orderCode,
      datetime}) async {
    for (var i = 0; i < productSnapshot.length; i++) {
      placeingOrder(true);
      //  await getProductDetails();
      var addProduct = firestore.collection(orderCollection).doc();
      addProduct.set({
        "order_by": currentUser!.uid,
        "order_by_name": Get.find<HomeController>().username,
        "order_by_email": currentUser!.email,
        "order_by_address": addressdeails["address"],
        "order_by_city": addressdeails["city"],
        "order_by_state": addressdeails["state"],
        "order_by_postalcode": addressdeails["postal_code"],
        "order_by_phone": addressdeails["phone"],
        "shapping_method": "Home Delivery",
        "order_payment": orderpayment,
        "order_place": true,
        //"total_amount": totalamount,
        "order_confirmed": false,
        "order_deliverd": false,
        "order_on_delivery": false,
        "venderId": productSnapshot[i]["venderID"],
        //"order": FieldValue.arrayUnion(products),
        "order": {
          "color": productSnapshot[i]["color"],
          "img": productSnapshot[i]["img"],
          "qty": productSnapshot[i]["quantity"],
          "tprice": productSnapshot[i]["tprice"],
          "title": productSnapshot[i]["title"],
          "prodcut_id": productSnapshot[i]["prodcut_id"]
        },

        "order_code": orderCode,
        "Order_date": datetime,
        "review": {"rating": "0.0", "review_des": ""},
        "product_doc_id": addProduct.id,
      });
      placeingOrder(false);
    }
  }

  getProductDetails() {
    products.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        "color": productSnapshot[i]["color"],
        "img": productSnapshot[i]["img"],
        "venderId": productSnapshot[i]["venderID"],
        "qty": productSnapshot[i]["quantity"],
        "tprice": productSnapshot[i]["tprice"],
        "title": productSnapshot[i]["title"],
        "prodcut_id": productSnapshot[i]["prodcut_id"]
      });
    }
  }

  cartClear() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }

  calculateTotalPrice(price, quantity) {
    totalprice.value = price * quantity;
  }

  resetValue(price, quantity) {
    totalprice.value = price;
    quantitycount.value = quantity;
  }

  addquntity(docid, quntity, price) async {
    islaoding(true);
    var addquntity = firestore.collection(cartCollection).doc(docid);
    await addquntity.set(
        {"quantity": quntity, "tprice": totalprice.value.toString()},
        SetOptions(merge: true)).then((value) => islaoding(false));
  }

  removequntity(docid, quntity, price) async {
    islaoding(true);
    var addquntity = firestore.collection(cartCollection).doc(docid);
    await addquntity.set(
        {"quantity": quntity, "tprice": totalprice.value.toString()},
        SetOptions(merge: true)).then((value) => islaoding(false));
  }
}
