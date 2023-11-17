import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/cart_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/pages/cart_page/address_details.dart';
import 'package:ecommerse_dev_app/widget_common/currency_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(CartController());
    // var pcontroller = Get.find<ProductController>();
    //  int quntity;
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        backgroundColor: whiteColor,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirestoreServices.getcartproduct(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset("assets/empty_cart.json"),
                  const Text(
                    "Cart is Empty",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ));
            } else {
              var data = snapshot.data!.docs;
              controller.productSnapshot = snapshot.data!.docs;
              controller.calculat(data);
              //controller.productSnapshot = data.length;

              return Scaffold(
                backgroundColor: whiteColor,
                body: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      // controller.productSnapshot = data[index];
                      controller.quantitycount.value = data[index]["quantity"];
                      return Column(
                        children: [
                          ListTile(
                              leading: Image.network(
                                data[index]["img"],
                              ),
                              title: Text(data[index]["title"]),
                              subtitle: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  currencyWidget(
                                      data: data[index]["tprice"].toString(),
                                      fontsize: 12),
                                  Row(
                                    children: [
                                      // ignore: unrelated_type_equality_checks
                                      controller.quantitycount == 1
                                          ? IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.remove))
                                          : IconButton(
                                              onPressed: () async {
                                                controller.calculateTotalPrice(
                                                    data[index]["price"],
                                                    data[index]["quantity"] -
                                                        1);
                                                await controller.removequntity(
                                                    data[index].id,
                                                    data[index]["quantity"] - 1,
                                                    controller
                                                        .totalprice.value);
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                color: darkFontGrey,
                                              )),
                                      Text(data[index]["quantity"].toString()),
                                      controller.quantitycount ==
                                              data[index]["product_quantity"]
                                          ? IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons.add))
                                          : IconButton(
                                              onPressed: () async {
                                                controller.calculateTotalPrice(
                                                    data[index]["price"],
                                                    data[index]["quantity"] +
                                                        1);
                                                await controller.addquntity(
                                                    data[index].id,
                                                    data[index]["quantity"] + 1,
                                                    controller
                                                        .totalprice.value);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                color: darkFontGrey,
                                              )),
                                    ],
                                  )
                                ],
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    FirestoreServices.cartdelete(
                                        data[index].id);
                                  },
                                  icon: const Icon(Icons.delete))),
                          const Divider(
                            color: fontGrey,
                          )
                        ],
                      );
                    })),
                bottomSheet: Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() => currencyWidget(
                          data: controller.totalcart.value.toString(),
                          fontsize: 18)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: redColor,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 48, vertical: 16)),
                          onPressed: () {
                            Get.to(() => const AddressDetails());
                          },
                          child: const Text("Continue"))
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
