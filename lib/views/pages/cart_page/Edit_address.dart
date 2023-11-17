import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/address_controller.dart';
import 'package:ecommerse_dev_app/widget_common/sizedbox_widget.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class EditAddress extends StatelessWidget {
  dynamic data;
  EditAddress({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller =
        TextEditingController(text: data["name"]);
    TextEditingController addresscontroller =
        TextEditingController(text: data["address"]);
    TextEditingController citycontroller =
        TextEditingController(text: data["city"]);
    TextEditingController statecontroller =
        TextEditingController(text: data["state"]);
    TextEditingController postalCodecontroller =
        TextEditingController(text: data["postal_code"]);
    TextEditingController phonecontroller =
        TextEditingController(text: data["phone"]);
    TextEditingController emailcontroller =
        TextEditingController(text: data["email"]);
    var controller = Get.put(addressControl());

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: whiteColor,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: namecontroller,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBoxwidget(height: 16),
            TextFormField(
              controller: addresscontroller,
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBoxwidget(height: 16),
            TextFormField(
              controller: citycontroller,
              decoration: const InputDecoration(
                labelText: "City",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBoxwidget(height: 16),
            TextFormField(
              controller: statecontroller,
              decoration: const InputDecoration(
                labelText: "State",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBoxwidget(height: 16),
            TextFormField(
              controller: postalCodecontroller,
              decoration: const InputDecoration(
                labelText: "Postal Code",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBoxwidget(height: 16),
            TextFormField(
              controller: emailcontroller,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBoxwidget(height: 16),
            TextFormField(
              controller: phonecontroller,
              decoration: const InputDecoration(
                labelText: "Phone",
                border: OutlineInputBorder(),
              ),
            ),
            sizedBoxwidget(height: 32),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 48, vertical: 16)),
                onPressed: () async {
                  await controller.updateAddress(
                      addresscontroller: addresscontroller.text,
                      citycontroller: citycontroller.text,
                      statecontroller: statecontroller.text,
                      postalCodecontroller: postalCodecontroller.text,
                      emailcontroller: emailcontroller.text,
                      phonecontroller: phonecontroller.text);
                  // ignore: use_build_context_synchronously
                  VxToast.show(context, msg: "Address Update");
                },
                child: const Text("Change Address")),
          ],
        ),
      ),
    );
  }
}
