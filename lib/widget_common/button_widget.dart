import 'package:ecommerse_dev_app/consts/consts.dart';

Widget buttonWidget({required String name, required Color bgcolor, Color? textcolor, onpress,double? width}) {
  return SizedBox(
    width: width,
    child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16), backgroundColor: bgcolor),
        onPressed: onpress,
        child: Text(
          name,
          style:
              TextStyle(fontSize: 18, fontFamily: semibold, color: textcolor),
        )),
  );
}
