import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/cart_controller.dart';
import 'package:ecommerse_dev_app/views/pages/home.dart';
import 'package:ecommerse_dev_app/widget_common/button_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:math';

List paymentImage = ["assets/images/rozarpay.png", "assets/images/cod.png"];
List paymentName = ["Rozarpay", "Cash On Delivery"];

class PaymentPage extends StatefulWidget {
  const PaymentPage({
    super.key,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _razorpay = Razorpay();
  var rndnumber = "";
  String formattedDate = "";

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void randomNumber() {
    var rnd = Random();
    for (var i = 0; i < 12; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
  }

  void getDateTime() {
    var now = DateTime.now();
    var formatter = DateFormat.yMd().add_jm();
    formattedDate = formatter.format(now);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    await controller
        .placeMyOrder(
            orderpayment: paymentName[controller.paymentindex.value],
            // totalamount: controller.totalcart.value,
            orderCode: rndnumber,
            datetime: formattedDate)
        .then((value) {
      controller.cartClear();
      VxToast.show(context, msg: "Order Place Successfully");
      Get.offAll(() => Home());
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  var controller = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: const Text("Choose Payment Method"),
          ),
          body: Obx(
            () => Column(
              children: List.generate(paymentImage.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.chnagePaymetIndex(index);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: controller.paymentindex.value == index
                                ? redColor
                                : darkFontGrey,
                            width: 1)),
                    margin: const EdgeInsets.all(16),
                    child: ListTile(
                        leading: Image.asset(
                          paymentImage[index],
                          fit: BoxFit.fill,
                        ),
                        title: Text(paymentName[index]),
                        trailing: controller.paymentindex.value == index
                            ? const Icon(
                                Icons.check_box,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.check_box,
                                color: Colors.transparent,
                              )),
                  ),
                );
              }),
            ),
          ),
          bottomNavigationBar: controller.placeingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : controller.paymentindex.value == 0
                  ? buttonWidget(
                      name: "Payment",
                      bgcolor: redColor,
                      onpress: () {
                        var options = {
                          'key': 'rzp_test_HCp0lrzi56DnFI',
                          'amount': (int.parse(
                                  controller.totalcart.value.toString()) *
                              100),
                          //in the smallest currency sub-unit.
                          'name': controller.addressdeails["name"],
                          for (int i = 0;
                              i < controller.productSnapshot.length;
                              i++)
                            'description': controller.productSnapshot[i]
                                    ["title"]
                                .toString(),
                          'timeout': 300, // in seconds
                          'prefill': {
                            // ignore: prefer_interpolation_to_compose_strings
                            'contact': "91" + controller.addressdeails["phone"],
                            'email': currentUser!.email,
                          }
                        };

                        _razorpay.open(options);

                        getDateTime();
                        randomNumber();
                      })
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: redColor),
                      onPressed: () {
                        controller.placeMyOrder(
                            orderpayment:
                                paymentName[controller.paymentindex.value],
                            //  totalamount: controller.totalcart.value,
                            orderCode: rndnumber,
                            datetime: formattedDate);
                      },
                      child: const Text(
                        "Cash On Delivery",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: semibold,
                            color: whiteColor),
                      ))),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }
}
