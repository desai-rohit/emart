import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/auth_controller.dart';
import 'package:ecommerse_dev_app/views/auth/sign_up.dart';
import 'package:ecommerse_dev_app/views/pages/home.dart';
import 'package:ecommerse_dev_app/widget_common/applogo_widget.dart';
import 'package:ecommerse_dev_app/widget_common/bg_widget.dart';
import 'package:ecommerse_dev_app/widget_common/textfild_widget.dart';
import 'package:get/get.dart';

import '../../widget_common/button_widget.dart';

const socialIconList = [icFacebookLogo, icGoogleLogo, icTwitterLogo];

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Obx(
          () => Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              appLogoWidget(),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0,
                          offset: Offset(0.0, 0.75))
                    ]),
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    textfildWidget(
                        ispass: false,
                        hinttext: "Enter Email",
                        fieldname: "email",
                        controller: controller.emailcontroller),
                    const SizedBox(
                      height: 8,
                    ),
                    textfildWidget(
                        ispass: true,
                        hinttext: "Enter password",
                        fieldname: "password",
                        controller: controller.passwordcontroller),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text("Forget Passowrd"))),
                    const SizedBox(
                      height: 16,
                    ),
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : buttonWidget(
                            name: "Log In",
                            bgcolor: redColor,
                            textcolor: whiteColor,
                            onpress: () async {
                              controller.isLoading(true);
                              await controller
                                  .loginMethod(context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: "loggedIn");
                                  Get.offAll(() => Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            }),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Create A New Account"),
                    const SizedBox(
                      height: 8,
                    ),
                    buttonWidget(
                        name: "Create Account",
                        bgcolor: lightGrey,
                        textcolor: redColor,
                        onpress: () {
                          Get.to(() => const SignUpScreen());
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 25,
                                  child: Image.asset(
                                    socialIconList[index],
                                  ),
                                ),
                              )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
