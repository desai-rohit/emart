import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/product_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/order_screen/order_widget.dart';
import 'package:ecommerse_dev_app/widget_common/button_widget.dart';
import 'package:ecommerse_dev_app/widget_common/sizedbox_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrderTetails extends StatelessWidget {
  dynamic data;
  OrderTetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    TextEditingController textEditingController =
        TextEditingController(text: data["review"]["review_des"]);
    // String reating = "0";

    return Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(title: const Text("Order Dtails")),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: whiteColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            data["order"]["img"],
                            width: 100,
                            height: 100,
                          ),
                          sizedBoxwidget(height: 8),
                          SizedBox(
                            width: 150,
                            child: Text(
                              maxLines: 3,
                              // ignore: prefer_interpolation_to_compose_strings
                              "Name \n" + data["order"]["title"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          sizedBoxwidget(height: 8),
                          Text("QTY ${data["order"]["qty"]}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          sizedBoxwidget(height: 8),
                          // ignore: prefer_interpolation_to_compose_strings
                          Text("seller id \n" + data["order"]["prodcut_id"],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "RS ${data["order"]["tprice"]}",
                            style: const TextStyle(
                                fontSize: 18,
                                color: redColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  )),
              data["order_deliverd"] == true
                  ? Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: whiteColor),
                      child: Column(
                        children: [
                          VxRating(
                            isSelectable: true,
                            value: double.parse(data["review"]["rating"]),
                            onRatingUpdate: (value) {
                              controller.reating.value = value;
                            },
                            normalColor: textfieldGrey,
                            selectionColor: golden,
                            maxRating: 5,
                            count: 5,
                            size: 25,
                          ),
                          sizedBoxwidget(height: 8),
                          Obx(() => Text(controller.reating.value)),
                          TextField(
                            controller: textEditingController,
                            maxLines: 10,
                            minLines: 5,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Review',
                            ),
                          ),
                          sizedBoxwidget(height: 8),
                          buttonWidget(
                              name: "Submit",
                              bgcolor: redColor,
                              textcolor: whiteColor,
                              onpress: () {
                                // controller.postreview(controller.reating.value,
                                //     textEditingController.text);
                                controller
                                    .review(
                                      controller.reating.value,
                                      textEditingController.text,
                                      data["product_doc_id"],
                                    )
                                    .then(
                                      (value) =>
                                          FirestoreServices.getAllOrders(),
                                    );
                              })
                        ],
                      ),
                    )
                  : Container(),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: whiteColor),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.thumb_up,
                        color: Colors.yellow.shade900,
                      ),
                      title: const Text("Order Confirmed"),
                      trailing: Icon(Icons.circle,
                          color: data["order_confirmed"] == true
                              ? Colors.blue
                              : Colors.grey),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.delivery_dining,
                        color: Colors.blue,
                      ),
                      title: const Text("On Delivery"),
                      trailing: Icon(Icons.circle,
                          color: data["order_on_delivery"] == true
                              ? Colors.blue
                              : Colors.grey),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.check_box,
                        color: Colors.green,
                      ),
                      title: const Text("Deliverd"),
                      trailing: Icon(Icons.circle,
                          color: data["order_deliverd"] == true
                              ? Colors.blue
                              : Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    orderWidget(
                        title1: "Order Code",
                        subtitle1: data['order_code'].toString(),
                        title2: "Shopping Method",
                        subtitle2: "Home Delivery",
                        subtitlefontsize1: 18,
                        subtitlecolor1: redColor),
                    const SizedBox(
                      height: 16,
                    ),
                    orderWidget(
                      title1: "Order Date & Time",
                      subtitle1: data["Order_date"],
                      title2: "Payment Method",
                      subtitle2: data["order_payment"],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    orderWidget(
                        title1: "Payment Status",
                        subtitle1: data["order_payment"] == "Cash On Delivery"
                            ? "post Paid"
                            : "Pripaid",
                        title2: "Delivery Status",
                        subtitle2: data["order_confirmed"] == true
                            ? "Order Confirmed"
                            : data["order_confirmed"] == true
                                ? "order_on_delivery"
                                : data["order_deliverd"] == true
                                    ? "Order Deliverd"
                                    : "On Progress"),
                    const SizedBox(
                      height: 16,
                    ),
                    orderWidget(
                        title1: "Shopping Address",
                        subtitle1:
                            "Rohit Desai\nnear bus stand\nkolhapur\nmaharshtra 416001\n4578215695",
                        title2: "Total Amount",
                        subtitle2: "RS ${data["order"]["tprice"]}",
                        subtitlefontsize2: 18,
                        subtitlecolor2: redColor),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16), color: whiteColor),
                child: Column(
                  children: [
                    orderListtile(
                        title: "Product Total",
                        trailing: data["order"]["tprice"].toString()),
                    orderListtile(
                        title: "Tax",
                        trailing: (int.parse(data["order"]["tprice"]) - 100)
                            .toString()),
                    orderListtile(title: "Delivery fee", trailing: "Free"),
                    const Divider(
                      color: darkFontGrey,
                    ),
                    orderListtile(
                        title: "Sub Total",
                        trailing: data["order"]["tprice"].toString()),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
