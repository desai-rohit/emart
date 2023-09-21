import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/cart_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/pages/cart_page/Edit_address.dart';
import 'package:ecommerse_dev_app/views/pages/cart_page/payment_page.dart';
import 'package:ecommerse_dev_app/widget_common/button_widget.dart';
import 'package:ecommerse_dev_app/widget_common/sizedbox_widget.dart';
import 'package:ecommerse_dev_app/widget_common/textfild_widget.dart';
import 'package:get/get.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic data;
    var controller = Get.find<CartController>();
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreServices.getAddAddress(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Scaffold(
              backgroundColor: whiteColor,
              appBar: AppBar(
                title: const Text("Address Details"),
              ),
              body: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      textfildWidget(
                          hinttext: "Name",
                          fieldname: "Name",
                          ispass: false,
                          controller: controller.nameController),
                      textfildWidget(
                          hinttext: "Address",
                          fieldname: "Address",
                          ispass: false,
                          controller: controller.addressController),
                      textfildWidget(
                          hinttext: "City",
                          fieldname: "City",
                          ispass: false,
                          controller: controller.cityController),
                      textfildWidget(
                          hinttext: "State",
                          fieldname: "State",
                          ispass: false,
                          controller: controller.stateController),
                      textfildWidget(
                          hinttext: "Postal Code",
                          fieldname: "Postal Code",
                          ispass: false,
                          controller: controller.postalcodeController),
                      textfildWidget(
                          hinttext: "Phone",
                          fieldname: "Phone",
                          ispass: false,
                          controller: controller.phoneController),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: buttonWidget(
                  name: "Continue",
                  bgcolor: redColor,
                  textcolor: darkFontGrey,
                  onpress: () {
                    controller.addAddress();
                    if (controller.addressController.text.length > 10) {
                      Get.to(() => const PaymentPage());
                    } else {
                      VxToast.show(context, msg: "Please Fill The Form");
                    }
                  }),
            );
          } else {
            data = snapshot.data!.docs;
            return data[0]["user_id"] != currentUser!.uid
                ? Scaffold(
                    backgroundColor: fontGrey,
                    appBar: AppBar(
                      title: const Text("Address Details"),
                    ),
                    body: Container(
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          textfildWidget(
                              hinttext: "Address",
                              fieldname: "Address",
                              ispass: false,
                              controller: controller.addressController),
                          textfildWidget(
                              hinttext: "City",
                              fieldname: "City",
                              ispass: false,
                              controller: controller.cityController),
                          textfildWidget(
                              hinttext: "State",
                              fieldname: "State",
                              ispass: false,
                              controller: controller.stateController),
                          textfildWidget(
                              hinttext: "Postal Code",
                              fieldname: "Postal Code",
                              ispass: false,
                              controller: controller.postalcodeController),
                          textfildWidget(
                              hinttext: "Phone",
                              fieldname: "Phone",
                              ispass: false,
                              controller: controller.phoneController)
                        ],
                      ),
                    ),
                    bottomNavigationBar: buttonWidget(
                        name: "Continue",
                        bgcolor: redColor,
                        onpress: () {
                          controller.addAddress();
                          if (controller.addressController.text.length > 10) {
                            Get.to(() => const PaymentPage());
                          } else {
                            VxToast.show(context, msg: "Please Fill The Form");
                          }
                        }),
                  )
                : Scaffold(
                    backgroundColor: lightGrey,
                    appBar: AppBar(
                      title: const Text("Address"),
                    ),
                    body: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              children: [
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                RichText(
                                    text: TextSpan(children: [
                                  const TextSpan(
                                    text: "Name ",
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: data[0]["name"] + "\n",
                                    style: const TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(height: 10),
                                  ),
                                  const TextSpan(
                                    text: "Address ",
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: data[0]["address"] + "\n",
                                    style: const TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(height: 10),
                                  ),
                                  const TextSpan(
                                    text: "City ",
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: data[0]["city"] + "\n",
                                    style: const TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "State ",
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: data[0]["state"] + "\n",
                                    style: const TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Postal Code ",
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: data[0]["postal_code"] + "\n",
                                    style: const TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Email ",
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: data[0]["email"] + "\n",
                                    style: const TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: "Phone ",
                                    style: TextStyle(
                                        color: darkFontGrey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(
                                    text: data[0]["phone"],
                                    style: const TextStyle(
                                      color: darkFontGrey,
                                      fontSize: 16,
                                    ),
                                  )
                                ])),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48, vertical: 16)),
                              onPressed: () {
                                controller.addressdeails = data[0];
                                Get.to(() => const PaymentPage());
                              },
                              child: const Text("Continue")),
                          sizedBoxwidget(height: 16),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 48, vertical: 16)),
                              onPressed: () {
                                Get.to(() => EditAddress(
                                      data: data[0],
                                    ));
                              },
                              child: const Text("Change Address"))
                        ],
                      ),
                    ),
                  );
          }
        },
      ),
    );
  }
}
