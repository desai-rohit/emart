import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/product_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: const Text("WishList"),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getAllWishlist(),
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
                  LottieBuilder.asset("assets/wishlist.json"),
                  const Text(
                    "No Item WishList",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ));
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network(
                        data[index]["p_images"][0],
                      ),
                      title: Text(
                        maxLines:2,
                          data[index]["p_name"].toString()),
                      subtitle: Text("Rs  ${data[index]["p_price"]}"),
                      trailing: IconButton(
                          onPressed: () {
                            controller.removeFormWishlist(
                                data[index].id, context);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: darkFontGrey,
                          )),
                    );
                  });
            }
          },
        ));
  }
}
