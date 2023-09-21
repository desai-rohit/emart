import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/views/auth/login_page.dart';
import 'package:ecommerse_dev_app/views/pages/home.dart';
import 'package:ecommerse_dev_app/widget_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<String> docId = [];

  Future getdocId() async {
    await FirebaseFirestore.instance
        .collection(cartCollection)
        .get()
        .then((value) => value.docs.forEach((element) {
              docId.add(element.reference.id);
            }));
  }

  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      //Get.to(() => const LoginScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.offAll(() => const LoginScreen());
        } else {
          Get.offAll(() => Home(
                docId: docId.toString(),
              ));
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    getdocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            appLogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    const SplashScreen();
  }
}
