import 'dart:async';

import 'package:ecommerse_dev_app/views/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  Timer? timer;
  User? user = FirebaseAuth.instance.currentUser;
  bool isEmialVerfied = false;
  Timer? count;
  int _counter = 60;

  @override
  void initState() {
    // TODO: implement initState
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      checkEmailVerfied();
    });
    count = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _counter--;
      });
      if (_counter == 0) {
        count!.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    count!.cancel();
    super.dispose();
  }

  Future checkEmailVerfied() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmialVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmialVerfied) {
      timer!.cancel();
      Get.offAll(() => Home());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text("Send Email Your Email Please Verifiy Email")),
          Center(child: Text("$_counter")),
          _counter == 0
              ? ElevatedButton(
                  onPressed: () async {
                    if (user != null && !user!.emailVerified) {
                      await user!.sendEmailVerification();
                    }

                    setState(() {
                      _counter = 60;
                    });

                    count = Timer.periodic(const Duration(seconds: 1), (timer) {
                      setState(() {
                        _counter--;
                      });
                      if (_counter == 0) {
                        count!.cancel();
                      }
                    });
                  },
                  child: const Text("Resend Email"))
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {},
                  child: const Text("Resend Email"))
        ],
      ),
    );
  }
}
