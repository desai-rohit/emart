import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/home_controller.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);
  var friendname = Get.arguments[0];
  var friendid = Get.arguments[1];
  var isloading = false.obs;

  var senderName = Get.find<HomeController>().username;
  var currentId = currentUser!.uid;

  var msgController = TextEditingController();

  dynamic chatDocId;

  getChatId() async {
    isloading(true);
    await chats
        .where("user", isEqualTo: {friendid: null, currentId: null})
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
          if (querySnapshot.docs.isNotEmpty) {
            chatDocId = querySnapshot.docs.single.id;
          } else {
            chats.add({
              "created_on": null,
              "last_msg": "",
              "user": {friendid: null, currentId: null},
              "toId": "",
              "formId": "",
              "friendId": friendid,
              "sender_name": senderName,
            }).then((value) {
              chatDocId = value.id;
            });
          }
        });
    isloading(false);
  }

  sendmsg(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocId).update({
        "created_on": FieldValue.serverTimestamp(),
        "last_msg": msg,
        "told": friendid,
        "formId": currentId
      });

      chats.doc(chatDocId).collection(messageCollection).doc().set({
        "created_on": FieldValue.serverTimestamp(),
        "msg": msg,
        "uid": currentId
      });
    }
  }
}
