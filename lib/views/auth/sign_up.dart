import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/auth_controller.dart';
import 'package:ecommerse_dev_app/views/auth/EmailVerification.dart';
import 'package:ecommerse_dev_app/views/auth/login_page.dart';
import 'package:ecommerse_dev_app/views/pages/home.dart';
import 'package:ecommerse_dev_app/widget_common/applogo_widget.dart';
import 'package:ecommerse_dev_app/widget_common/bg_widget.dart';
import 'package:ecommerse_dev_app/widget_common/textfild_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../widget_common/button_widget.dart';

const socialIconList = [icFacebookLogo, icGoogleLogo, icTwitterLogo];

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? ischeck = false;
  var controller = Get.put(AuthController());

  // text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypepassowrdController = TextEditingController();
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    void sizedbox(double size) {
      SizedBox(
        height: size,
      );
    }

    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                        hinttext: "Enter Name",
                        fieldname: "Name",
                        controller: nameController),
                    const SizedBox(
                      height: 8,
                    ),
                    textfildWidget(
                        ispass: false,
                        hinttext: "Enter email",
                        fieldname: "email",
                        controller: emailController),
                    const SizedBox(
                      height: 8,
                    ),
                    textfildWidget(
                        hinttext: "Enter password",
                        fieldname: "password",
                        controller: passwordController,
                        ispass: false),
                    const SizedBox(
                      height: 8,
                    ),
                    textfildWidget(
                        hinttext: "Enter retpepassword",
                        fieldname: "retypassword",
                        controller: retypepassowrdController,
                        ispass: false),
                    Row(
                      children: [
                        Checkbox(
                            checkColor: redColor,
                            value: ischeck,
                            onChanged: (newvalue) {
                              setState(() {
                                ischeck = newvalue;
                              });
                            }),
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(color: fontGrey)),
                            TextSpan(
                                text: "Terms And Condition ",
                                style: TextStyle(color: redColor)),
                            TextSpan(
                                text: "& ", style: TextStyle(color: fontGrey)),
                            TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(color: redColor)),
                          ])),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    buttonWidget(
                        name: "Sign UP",
                        bgcolor: ischeck == true ? redColor : lightGrey,
                        textcolor: whiteColor,
                        onpress: () async {
                          if (ischeck != false) {
                            try {
                              if (controller.passwwordvalidateStructure(
                                      passwordController.text) !=
                                  true) {
                                VxToast.show(context, msg: "Week Password");
                              } else if (passwordController.text !=
                                  retypepassowrdController.text) {
                                VxToast.show(context,
                                    msg: "Password Not Match");
                              } else if (nameController.text.isEmpty &&
                                  emailController.text.isEmpty &&
                                  passwordController.text.isEmpty &&
                                  retypepassowrdController.text.isEmpty) {
                                VxToast.show(context,
                                    msg: "please All Filed Fill");
                              } else {
                                await controller
                                    .signupMethod(emailController.text,
                                        passwordController.text, context)
                                    .then((value) => controller.storeUserData(
                                        nameController.text,
                                        passwordController.text,
                                        emailController.text))
                                    .then((value) async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;

                                  if (user != null && !user.emailVerified) {
                                    await user.sendEmailVerification().then(
                                        (value) => Get.offAll(
                                            () => const EmailVerification()));
                                  } else {
                                    VxToast.show(context,
                                        msg: 'Logeed In Successful');
                                    Get.offAll(() => Home());
                                  }
                                });
                              }
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                            }
                          }
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Alredy Create Account"),
                    const SizedBox(
                      height: 8,
                    ),
                    buttonWidget(
                        name: "Log In",
                        bgcolor: lightGrey,
                        textcolor: redColor,
                        onpress: () {
                          Get.to(() => const LoginScreen());
                        }),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => GestureDetector(
                                onTap: () {
                                  googleSignIn.signIn().then((value) {
                                    String username = value!.displayName!;
                                    String profile = value.photoUrl!;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 25,
                                    child: Image.asset(
                                      socialIconList[index],
                                    ),
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
