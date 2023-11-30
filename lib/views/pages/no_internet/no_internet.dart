import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatefulWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  State<NoInternet> createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/no_internet.json',height: 250,width: 250),
          const Center(
            child: Text(
              "No Internet Connection",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 84, 153)),
            ),
          ),
          const Center(
            child: Text(
              "Please Check Internet",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 84, 153)),
            ),
          )
        ],
      )),
    );
  }
}
