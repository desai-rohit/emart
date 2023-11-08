import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/order_screen/order_details.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text("Order"),
        ),
        body: FutureBuilder(
          future: FirestoreServices.getAllOrders(),
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
                  LottieBuilder.asset("assets/no_order.json"),
                  const Text(
                    "No Order Yet",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ));
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => OrderTetails(
                              data: data[index],
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          tileColor:  Colors.grey.shade300,
                          leading: Image.network(data[index]["order"]["img"]),
                          title: Text(
                              maxLines: 2,
                              data[index]["order"]["title"].toString()),
                          subtitle: Text("₹${data[index]["order"]["tprice"]}"),
                          trailing: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: darkFontGrey,
                              )),
                        ),
                      )
                    );
                  });
            }
          },
        ));
  }
}
