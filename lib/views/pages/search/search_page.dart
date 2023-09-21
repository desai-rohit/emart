import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/pages/product_details_page/prodcut_deails.dart';
import 'package:ecommerse_dev_app/widget_common/currency_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  dynamic searchText;
  SearchPage({super.key, required this.searchText});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGrey,
        body: Container(
          margin: const EdgeInsets.all(16),
          child: FutureBuilder(
              future: FirestoreServices.getsearchresult(searchText),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  const Text("No Prodct Found");
                }
                var searchData = snapshot.data!.docs;
                return GridView.builder(
                    itemCount: searchData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 300),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // controller.calculateTotalPrice(
                          //     int.parse(data[index]["p_price"]));
                          Get.to(() => ProdcutDetails(data: searchData[index]));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                searchData[index]["p_images"][0],
                                width: 200,
                                cacheWidth: 300,
                                fit: BoxFit.fill,
                              ),
                              const Spacer(),
                              Text(searchData[index]["p_name"]),
                              currencyWidget(
                                  data: searchData[index]["p_price"],
                                  fontsize: 18)
                            ],
                          ),
                        ),
                      );
                    });
              }),
        ),
      ),
    );
  }
}
