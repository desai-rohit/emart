import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/product_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/chat/chat_page.dart';
import 'package:ecommerse_dev_app/views/pages/cart_page/address_details.dart';
import 'package:ecommerse_dev_app/widget_common/button_widget.dart';
import 'package:ecommerse_dev_app/widget_common/container_widget.dart';
import 'package:ecommerse_dev_app/widget_common/currency_widget.dart';
import 'package:ecommerse_dev_app/widget_common/text_widget.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class ProdcutDetails extends StatefulWidget {
  dynamic data;
  ProdcutDetails({super.key, this.data});

  @override
  State<ProdcutDetails> createState() => _ProdcutDetailsState();
}

class _ProdcutDetailsState extends State<ProdcutDetails> {
  var controller = Get.find<ProductController>();
  late String colorname;

  @override
  void initState() {
    super.initState();
    //colorname = widget.data["col"][0]["namecolors"];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.resetValue(int.parse(widget.data["p_price"]));
        controller.calculateTotalPrice(int.parse(widget.data["p_price"]));

        return true;
      },
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            elevation: 0,
            title: Text(
              widget.data["p_name"],
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    if (controller.isfav.value) {
                      controller.removeFormWishlist(widget.data.id, context);
                      //controller.isfav(false);
                    } else {
                      controller.addToWishlist(widget.data.id, context);
                      //  controller.isfav(true);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color:
                        controller.isfav.value ? Colors.red[300] : whiteColor,
                  )),
              IconButton(
                  onPressed: () async {
                    final url = Uri.parse(widget.data["p_images"][0]);

                    final response = await http.get(url);
                    final bytes = response.bodyBytes;

                    final temp = await getTemporaryDirectory();
                    final path = "${temp.path}/image.jpg";
                    File(path).writeAsBytesSync(bytes);

                    // ignore: deprecated_member_use
                    await Share.shareFiles([path], text: widget.data["p_name"]);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: whiteColor,
                  )),
            ],
          ),
          backgroundColor: lightGrey,
          body: FutureBuilder(
              future: FirestoreServices.getreview(),
              builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  var reviewData = snapshot.data!.docs;

                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            VxSwiper.builder(
                                aspectRatio: 16 / 9,
                                itemCount: widget.data["p_images"].length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(8),
                                    child: CachedNetworkImage(
                                      memCacheHeight: 300,
                                      height: 300,
                                      imageUrl: widget.data["p_images"][index],
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }),
                            textWidget(
                                text: widget.data["p_name"],
                                color: darkFontGrey,
                                fontsize: 18),
                            const SizedBox(
                              height: 16,
                            ),
                            VxRating(
                              isSelectable: false,
                              value: 5,
                              onRatingUpdate: (value) {},
                              normalColor: textfieldGrey,
                              selectionColor: golden,
                              maxRating: 5,
                              count: 5,
                              size: 25,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            textWidget(
                                // ignore: prefer_interpolation_to_compose_strings
                                text: "Quantity " + widget.data['p_quantity'],
                                color: darkFontGrey,
                                fontsize: 18),
                            const SizedBox(
                              height: 16,
                            ),
                            containerWidget(
                              whiteColor,
                              16,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            controller.decresequantity();
                                            controller.calculateTotalPrice(
                                                int.parse(widget.data["p_price"]));
                                          },
                                          icon: const Icon(Icons.remove)),
                                      controller.quantitycount.value.text
                                          .size(16)
                                          .color(darkFontGrey)
                                          .fontFamily(regular)
                                          .make(),
                                      IconButton(
                                          onPressed: () {
                                            controller.incresequantity(int.parse(
                                                widget.data["p_quantity"]));
                                            controller.calculateTotalPrice(
                                                int.parse(widget.data["p_price"]));
                                          },
                                          icon: const Icon(Icons.add))
                                    ],
                                  ),

                                   Obx(() => Text("₹ ${controller.totalprice.value.numCurrency}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.green),))
                                  //  controller.totalprice.value.text
                                  //     .size(24)
                                  //     .color(Colors.green)
                                  //     .fontFamily(regular)
                                  //     .make()),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              padding: const EdgeInsets.all(16),
                              color: Colors.lightGreen.shade100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textWidget(
                                      text:
                                          "${widget.data["p_discount"].toStringAsFixed(0)}% off",
                                      color: Colors.green,
                                      fontsize: 18),
                                  textWidget(
                                      text: "₹ ${widget.data['p_oprice']}",
                                      color: darkFontGrey,
                                      fontsize: 18,
                                      lineThrougn: TextDecoration.lineThrough),
                                  currencyWidget(
                                      data: widget.data["p_price"],
                                      fontsize: 18),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: Text(
                                textAlign: TextAlign.center,
                                widget.data["p_desc"].toString(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            
                            const SizedBox(
                              height: 16,
                            ),
                            IconButton(
                                onPressed: () {
                                  Get.to(() => const ChatPage(), arguments: [
                                    widget.data["p_seller"],
                                    widget.data["sellerid"]
                                  ]);
                                },
                                icon: const Icon(Icons.message)),
                            SizedBox(
                              height: 350,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: reviewData.length,
                                  itemBuilder: ((context, index) {
                                    controller.ratingavg.value = index;
                                    return reviewData[index]["order"]
                                                ["prodcut_id"] ==
                                            widget.data["product_id"] && reviewData[index]["review"]["rating"] !="0.0"
                                        ? ListTile(
                                            leading: const CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg/330px-Outdoors-man-portrait_%28cropped%29.jpg"),
                                            ),
                                            title: Text(reviewData[index]
                                                ["order_by_name"]),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                VxRating(
                                                  isSelectable: false,
                                                  value: double.parse(
                                                    reviewData[index]["review"]
                                                            ["rating"]
                                                        .toString(),
                                                  ),
                                                  onRatingUpdate: (value) {},
                                                  normalColor: textfieldGrey,
                                                  selectionColor: golden,
                                                  maxRating: 5,
                                                  count: 5,
                                                  size: 15,
                                                ),
                                                Text(reviewData[index]["review"]
                                                    ["review_des"]),
                                              ],
                                            ),
                                          )
                                        : Container();
                                  })),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              })),
          bottomSheet: Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buttonWidget(
                    width: MediaQuery.of(context).size.width * 0.48,
                    name: "Add To Cart",
                    bgcolor: redColor,
                    textcolor: whiteColor,
                    onpress: () {
                      controller.addToCart(
                          venderId: widget.data["sellerid"],
                          color: widget.data["colorsname"],
                          context: context,
                          img: widget.data["p_images"][0],
                          quantity: controller.quantitycount.value,
                          seller: widget.data["p_seller"],
                          title: widget.data["p_name"],
                          tprice: controller.totalprice.value.toString(),
                          price: int.parse(
                            widget.data["p_price"],
                          ),
                          productquantity: int.parse(widget.data["p_quantity"]),
                          productId: widget.data["product_id"]);
                      VxToast.show(context, msg: "Added To Cart");
                    }),
                buttonWidget(
                    width: MediaQuery.of(context).size.width * 0.48,
                    name: "Buy Now",
                    bgcolor: redColor,
                    textcolor: whiteColor,
                    onpress: () {
                      controller.addToCart(
                          venderId: widget.data["sellerid"],
                          color: widget.data["colorsname"],
                          context: context,
                          img: widget.data["p_images"][0],
                          quantity: controller.quantitycount.value,
                          seller: widget.data["p_seller"],
                          title: widget.data["p_name"],
                          tprice: controller.totalprice.value.toString(),
                          price: int.parse(
                            widget.data["p_price"],
                          ),
                          productquantity:
                              int.parse(widget.data["p_quantity"]));
                      Get.to(() => const AddressDetails());
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
