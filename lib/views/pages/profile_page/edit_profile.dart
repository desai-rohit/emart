import 'dart:io';

import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/profile_controller.dart';
import 'package:ecommerse_dev_app/widget_common/bg_widget.dart';
import 'package:ecommerse_dev_app/widget_common/button_widget.dart';
import 'package:ecommerse_dev_app/widget_common/sizedbox_widget.dart';
import 'package:ecommerse_dev_app/widget_common/textfild_widget.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  final dynamic data;
  const EditProfile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.white),
          child: Center(
            child: Obx(
              () => controller.isloading.value
                  ? const CircularProgressIndicator()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 50,
                            backgroundImage: data["imageurl"] == "" &&
                                    controller.profileimagepath.isEmpty
                                ? const AssetImage('assets/images/profile2.png')
                                : data["imageurl"] != "" &&
                                        controller.profileimagepath.isEmpty
                                    ? NetworkImage(data["imageurl"])
                                    : FileImage(File(
                                            controller.profileimagepath.value))
                                        as ImageProvider),
                        sizedBoxwidget(height: 8),
                        buttonWidget(
                            name: "chnage",
                            bgcolor: redColor,
                            textcolor: whiteColor,
                            onpress: () {
                              controller.chnageImage(context);
                            }),
                        const Divider(
                          color: Colors.grey,
                        ),
                        textfildWidget(
                            controller: controller.namecontroller,
                            hinttext: data["name"],
                            fieldname: "Name",
                            ispass: false),
                        textfildWidget(
                            controller: controller.newpasswordcontroller,
                            hinttext: "Enter New Password",
                            fieldname: "New password",
                            ispass: true),
                        textfildWidget(
                            controller: controller.oldpasswordcontroller,
                            hinttext: "Enter Old Password",
                            fieldname: "Old password",
                            ispass: true),
                        sizedBoxwidget(height: 16),
                        buttonWidget(
                            width: MediaQuery.of(context).size.width * 0.50,
                            name: "save",
                            bgcolor: redColor,
                            onpress: () async {
                              controller.isloading(true);

                              // if not select new image
                              if (controller
                                  .profileimagepath.value.isNotEmpty) {
                                await controller.uploadProfileImage();
                              } else {
                                controller.profileimagelink = data["imageurl"];
                              }

                              // if password match
                              if (data["password"] ==
                                  controller.oldpasswordcontroller.text) {
                                await controller.chnageAuthPassword(
                                    data["email"],
                                    controller.oldpasswordcontroller.text,
                                    controller.newpasswordcontroller.text);

                                await controller.updateProfile(
                                  imageurl: controller.profileimagelink,
                                  name: controller.namecontroller.text,
                                  password:
                                      controller.newpasswordcontroller.text,
                                );
                                // ignore: use_build_context_synchronously
                                VxToast.show(context, msg: "Profile Updated");
                                controller.isloading(false);
                              } else {
                                // ignore: use_build_context_synchronously
                                VxToast.show(context,
                                    msg: "Wrong Old Password");
                                controller.isloading(false);
                              }
                            })
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
