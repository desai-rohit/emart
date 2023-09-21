import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/widget_common/currency_widget.dart';

Widget featuresProdcut({dynamic data}) {
  return GestureDetector(
    child: Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: whiteColor, borderRadius: BorderRadius.circular(16)),
      height: 250,
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.network(
              data["p_images"][0],
              width: 100,
              height: 100,
            ),
          ),
          Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              data["p_name"].toString()),
          currencyWidget(data: data["p_price"], fontsize: 18)
        ],
      ),
    ),
  );
}
