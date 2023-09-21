import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/views/pages/category_screen/list/list.dart';

Widget sliderwidget() {
  return VxSwiper.builder(
      aspectRatio: 16 / 9,
      autoPlay: true,
      height: 150,
      enlargeCenterPage: true,
      itemCount: sliderList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              sliderList[index],
              fit: BoxFit.fill,
            ),
          ),
        );
      });
}
