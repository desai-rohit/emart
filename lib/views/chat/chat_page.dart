import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/chats_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/widget_common/text_widget.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: textWidget(text: "Rohit", color: darkFontGrey, fontsize: 18),
      ),
      body:

          // Obx(
          //   () => controller.isloading.value
          //       ? Center(
          //           child: CircularProgressIndicator(),
          //         )
          //       :

          FutureBuilder(
        future:
            FirestoreServices.getchatMessages(controller.chatDocId.toString()),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Send a message..."),
            );
          } else {
            return ListView(
                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
              var data = snapshot.data!.docs[index];
              return Container(
                  margin: const EdgeInsets.only(
                      left: 56, right: 16, top: 16, bottom: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(32),
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: Column(
                    children: [
                      Text(data["msg"]),
                      textWidget(
                          text: "${data["msg"]}",
                          color: darkFontGrey,
                          fontsize: 18),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: textWidget(
                              text: "10.30 AM",
                              color: darkFontGrey,
                              fontsize: 12))
                    ],
                  ));
            }).toList());
          }
        },
      ),
      bottomSheet: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.msgController,
                decoration: const InputDecoration(
                    hintText: "Type A Message...",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: textfieldGrey))),
              ),
            ),
            IconButton(
                onPressed: () {
                  controller.sendmsg(controller.msgController.text);
                  controller.msgController.clear();
                },
                icon: const Icon(Icons.send)),
          ],
        ),
      ),
    );
  }
}
