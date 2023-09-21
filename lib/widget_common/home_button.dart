import 'package:ecommerse_dev_app/consts/consts.dart';

Widget homeButton(String text, height, width, String icon) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(boxShadow: const <BoxShadow>[
      BoxShadow(color: fontGrey, blurRadius: 10.0, offset: Offset(0.0, 0.75))
    ], color: whiteColor, borderRadius: BorderRadius.circular(16)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          icon,
          fit: BoxFit.cover,
          width: 32,
          height: 32,
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          textAlign: TextAlign.center,
          text,
          style: const TextStyle(color: Colors.black),
        )
      ],
    ),
  );
}
