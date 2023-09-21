import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/views/pages/home.dart';
import 'package:ecommerse_dev_app/widget_common/sizedbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PlaceOrder extends StatelessWidget {
  const PlaceOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 181, 186, 247),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Lottie.asset('assets/order_ani.json')),
          const Text(
            "Order Successful",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          sizedBoxwidget(height: 96),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 76, 79, 175),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
              onPressed: () {
                Get.to(() => Home());
              },
              child: const Text("Countinue Shopping"))
        ],
      ),
    );
  }
}
