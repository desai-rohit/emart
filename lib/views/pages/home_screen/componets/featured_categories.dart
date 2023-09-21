import 'package:ecommerse_dev_app/consts/consts.dart';

Widget featuresCategories(String image, String title) {
  return Container(
    width: 200,
    margin: const EdgeInsets.symmetric(horizontal: 4),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: whiteColor,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        Image.asset(
          image,
          width: 50,
          height: 100,
          cacheHeight: 200,
          cacheWidth: 200,
        ),
        Text(title)
      ],
    ),
  );
}
