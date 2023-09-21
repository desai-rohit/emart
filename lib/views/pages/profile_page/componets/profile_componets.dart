import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/widget_common/text_widget.dart';

Widget profileCard({required String text1, required String text2, context}) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.3,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(8)),
    child: Column(
      children: [
        textWidget(text: text1, color: darkFontGrey, fontsize: 18),
        textWidget(text: text2, color: darkFontGrey, fontsize: 18),
      ],
    ),
  );
}
