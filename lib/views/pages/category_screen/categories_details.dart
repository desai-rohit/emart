import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/product_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/pages/product_details_page/prodcut_deails.dart';
import 'package:ecommerse_dev_app/widget_common/bg_widget.dart';
import 'package:ecommerse_dev_app/widget_common/currency_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CategoriesDetails extends StatelessWidget {
  dynamic title;
  dynamic todaydeal;
  dynamic flashseal;
  CategoriesDetails({super.key, this.title, this.todaydeal, this.flashseal});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(todaydeal == "Today Deals"
                ? todaydeal
                : flashseal == "Flash Seal"
                    ? flashseal
                    : title),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search))
            ],
          ),
          body: FutureBuilder(
            future: todaydeal == "Today Deals"
                ? FirestoreServices.todayDeals()
                : flashseal == "Flash Seal"
                    ? FirestoreServices.flashSeal()
                    : FirestoreServices.getProduct(title),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text("No Prodct Found This Category"),
                );
              } else {
                var data = snapshot.data!.docs;
                return Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                controller.subcat.length,
                                (index) => Container(
                                      height: 70,
                                      width: 100,
                                      padding: const EdgeInsets.all(16),
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child:
                                              Text(controller.subcat[index])),
                                    ))),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Expanded(
                        child: GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    mainAxisExtent: 250),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.calculateTotalPrice(
                                      int.parse(data[index]["p_price"]));
                                  controller.checkIfFav(data[index]);
                                  Get.to(() => ProdcutDetails(
                                        data: data[index],
                                      ));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      boxShadow: const <BoxShadow>[
                                        BoxShadow(
                                            color: fontGrey,
                                            blurRadius: 4.0,
                                            offset: Offset(
                                              0.44,
                                              0.75,
                                            ))
                                      ],
                                      color: whiteColor,
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: CachedNetworkImage(
                                          height: 150,
                                          imageUrl: data[index]["p_images"][0],
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                      Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          data[index]["p_name"].toString()),
                                      currencyWidget(
                                          data: data[index]["p_price"],
                                          fontsize: 18)
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }
            }),
          )),
    );
  }
}
