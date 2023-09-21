import 'package:ecommerse_dev_app/consts/consts.dart';

textfildWidget(
    {String? hinttext,
    String? fieldname,
    TextEditingController? controller,
    ispass,
    Color? colors}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        fieldname!,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontFamily: semibold),
      ),
      const SizedBox(
        height: 4,
      ),
      TextField(
        obscureText: ispass,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
          hintText: hinttext,
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide()),
          // focusedBorder: OutlineInputBorder(
          //     borderSide: BorderSide(color: Colors.red, width: 2)),
        ),
      ),
    ],
  );
}
