import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/product_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/pages/category_screen/categories_details.dart';
import 'package:ecommerse_dev_app/views/pages/home_screen/componets/slider.dart';
import 'package:ecommerse_dev_app/views/pages/product_details_page/prodcut_deails.dart';
import 'package:ecommerse_dev_app/views/pages/home_screen/componets/featured_categories.dart';
import 'package:ecommerse_dev_app/views/pages/home_screen/componets/features_product.dart';
import 'package:ecommerse_dev_app/views/pages/category_screen/list/list.dart';
import 'package:ecommerse_dev_app/views/pages/search/search_page.dart';
import 'package:ecommerse_dev_app/widget_common/currency_widget.dart';
import 'package:ecommerse_dev_app/widget_common/home_button.dart';
import 'package:ecommerse_dev_app/widget_common/sizedbox_widget.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    TextEditingController searchController = TextEditingController();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "eMart",
            style:
                GoogleFonts.lobster(textStyle: const TextStyle(fontSize: 32)),
          ),
          centerTitle: true,
        ),
        backgroundColor: lightGrey,
        body: FutureBuilder(
          future: FirestoreServices.getAllProduct(),
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');

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

              return SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          autofocus: false,
                          textInputAction: TextInputAction.search,
                          onEditingComplete: () {
                            Get.to(() =>
                                SearchPage(searchText: searchController.text));
                          },
                          controller: searchController,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32)),
                            hintText: "Search Anything...",
                          ),
                        ),
                        sizedBoxwidget(height: 24),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          child: Column(children: [
                            sliderwidget(),
                            sizedBoxwidget(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => CategoriesDetails(
                                          todaydeal: "Today Deals",
                                        ));
                                  },
                                  child: homeButton(
                                      "Today Deals",
                                      MediaQuery.of(context).size.width / 3.5,
                                      MediaQuery.of(context).size.width / 2.5,
                                      icFlashDeal),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => CategoriesDetails(
                                          flashseal: "Flash Seal",
                                        ));
                                  },
                                  child: homeButton(
                                      "Flash Seal",
                                      MediaQuery.of(context).size.width / 3.5,
                                      MediaQuery.of(context).size.width / 2.5,
                                      icTodaysDeal),
                                )
                              ],
                            ),
                            sizedBoxwidget(height: 16),
                            sliderwidget(),
                            sizedBoxwidget(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                3,
                                (index) => homeButton(
                                    index == 0
                                        ? "Popular Product"
                                        : index == 1
                                            ? "Top Brands"
                                            : "Top Seller",
                                    MediaQuery.of(context).size.height / 7,
                                    MediaQuery.of(context).size.width / 3.5,
                                    index == 0
                                        ? icTopCategories
                                        : index == 1
                                            ? icBrands
                                            : icTopSeller),
                              ),
                            ),
                            sizedBoxwidget(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Featured Categories",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: semibold),
                              ),
                            ),
                            sizedBoxwidget(height: 4),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                    featuresImage1.length,
                                    (index) => Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => CategoriesDetails(
                                                    title:
                                                        featuresTitle1[index]));
                                              },
                                              child: featuresCategories(
                                                  featuresImage1[index],
                                                  featuresTitle1[index]),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => CategoriesDetails(
                                                    title:
                                                        featuresTitle2[index]));
                                              },
                                              child: featuresCategories(
                                                  featuresImage2[index],
                                                  featuresTitle2[index]),
                                            )
                                          ],
                                        )),
                              ),
                            ),
                            sizedBoxwidget(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Featured Product",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: semibold),
                              ),
                            ),
                            sizedBoxwidget(height: 4),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                children: List.generate(
                                    data.length,
                                    (index) => data[index]["p_featured"] == true
                                        ? GestureDetector(
                                            onTap: () {
                                              controller.calculateTotalPrice(
                                                  int.parse(
                                                      data[index]["p_price"]));
                                              Get.to(() => ProdcutDetails(
                                                  data: data[index]));
                                            },
                                            child: featuresProdcut(
                                                data: data[index]))
                                        : Container()),
                              ),
                            ),
                            sizedBoxwidget(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "All Product",
                                style: TextStyle(
                                    fontSize: 18, fontFamily: semibold),
                              ),
                            ),
                            sizedBoxwidget(height: 4),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        mainAxisExtent: 300),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.calculateTotalPrice(
                                          int.parse(data[index]["p_price"]));
                                      Get.to(() =>
                                          ProdcutDetails(data: data[index]));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Image.network(
                                              data[index]["p_images"][0],
                                              width: 150,
                                              cacheWidth: 300,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Text(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              data[index]["p_name"].toString()),
                                          currencyWidget(
                                              data: data[index]["p_price"],
                                              fontsize: 18)
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
        ));
  }
}
