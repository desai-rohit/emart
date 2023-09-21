import 'package:ecommerse_dev_app/consts/consts.dart';

Widget orderWidget({
  required String title1,
  required String subtitle1,
  required String title2,
  required String subtitle2,
  Color? subtitlecolor1,
  double? subtitlefontsize1,
  Color? subtitlecolor2,
  double? subtitlefontsize2,
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textAlign: TextAlign.start,
                title1,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                textAlign: TextAlign.start,
                subtitle1,
                style: TextStyle(
                    fontSize: subtitlefontsize1, color: subtitlecolor1),
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title2,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Text(
                subtitle2,
                style: TextStyle(
                    fontSize: subtitlefontsize2, color: subtitlecolor2),
              )
            ],
          )
        ],
      ),
    ],
  );
}

Widget orderListtile(
    {required String title,
    required String trailing,
    double? fontsize,
    Color? tcolor}) {
  return ListTile(
    title: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    trailing: Text(
      trailing,
      style: TextStyle(
          fontSize: fontsize, fontWeight: FontWeight.bold, color: tcolor),
    ),
  );
}
