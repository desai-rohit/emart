import 'package:ecommerse_dev_app/consts/consts.dart';

Widget textWidget(
    {required String text,
    required Color color,
    String? fontfamily,
    required double fontsize,
    TextDecoration? lineThrougn}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontsize,
        color: color,
        fontFamily: fontfamily,
        decoration: lineThrougn),
  );
}
