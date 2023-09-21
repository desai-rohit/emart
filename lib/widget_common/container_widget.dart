import 'package:ecommerse_dev_app/consts/consts.dart';

Widget containerWidget(Color bgcolor, double borderradius, widget) {
  return Container(
    decoration: BoxDecoration(
      color: bgcolor,
      borderRadius: BorderRadius.circular(borderradius),
    ),
    child: widget,
  );
}
