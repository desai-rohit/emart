import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/profile_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/auth/login_page.dart';
import 'package:ecommerse_dev_app/views/order_screen/order_page.dart';
import 'package:ecommerse_dev_app/views/pages/profile_page/edit_profile.dart';
import 'package:ecommerse_dev_app/views/wishlist/wishlist_page.dart';
import 'package:ecommerse_dev_app/widget_common/bg_widget.dart';
import 'package:ecommerse_dev_app/widget_common/button_widget.dart';
import 'package:ecommerse_dev_app/widget_common/sizedbox_widget.dart';
import 'package:ecommerse_dev_app/widget_common/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

List name = ["My Order", "My WishList"];
List icon = [
  const Icon(Icons.shopping_bag),
  const Icon(Icons.favorite),
];

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
          body: FutureBuilder(
              future: FirestoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  var data = snapshot.data!.docs[0];
                  return SafeArea(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 50,
                                backgroundImage: data["imageurl"] == ""
                                    ? const AssetImage(
                                        'assets/images/profile2.png')
                                    : NetworkImage(data["imageurl"])
                                        as ImageProvider),
                            sizedBoxwidget(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textWidget(
                                    text: data["name"],
                                    color: whiteColor,
                                    fontsize: 18),
                                textWidget(
                                    text: data["email"],
                                    color: whiteColor,
                                    fontsize: 12),
                              ],
                            ),
                            Row(
                              children: [
                                // buttonWidget("Log Out", redColor, whiteColor, () {}),
                                IconButton(
                                    onPressed: () {
                                      controller.namecontroller.text =
                                          data["name"];

                                      Get.to(() => EditProfile(
                                            data: data,
                                          ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: whiteColor,
                                    ))
                              ],
                            )
                          ],
                        ),
                        sizedBoxwidget(height: 16),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     profileCard(
                        //         context: context,
                        //         text1: data["cartcount"],
                        //         text2: "Cart"),
                        //     profileCard(
                        //         context: context,
                        //         text1: data["wishcount"],
                        //         text2: " WishList"),
                        //     profileCard(
                        //         context: context,
                        //         text1: data["ordercount"],
                        //         text2: "Order"),
                        //   ],
                        // ),
                        Container(
                          color: redColor,
                          child: Container(
                              margin: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: whiteColor),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        switch (index) {
                                          case 0:
                                            Get.to(() => const OrderPage());
                                            break;
                                          case 1:
                                            Get.to(() => const WishListPage());
                                            break;

                                        }
                                      },
                                      leading: icon[index],
                                      title: Text(
                                        name[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      color: darkFontGrey,
                                    );
                                  },
                                  itemCount: name.length)),
                        ),
                        sizedBoxwidget(height: 16),
                        buttonWidget(
                            width: MediaQuery.of(context).size.width * 0.50,
                            name: "Sign Out",
                            bgcolor: redColor,
                            onpress: () {
                              FirebaseAuth.instance.signOut().then((value) =>
                                  Get.offAll(() => const LoginScreen()));
                            },
                            textcolor: whiteColor)
                      ],
                    ),
                  );
                }
              })),
    );
  }
}
