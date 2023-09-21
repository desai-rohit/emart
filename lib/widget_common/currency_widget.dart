import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:intl/intl.dart';

Widget currencyWidget({
  data,
  double? fontsize,
}) {
  return Text(
    NumberFormat.currency(
      symbol: "₹ ",
      locale: "HI",
      decimalDigits: 0,
    ).format(int.parse(data)),
    // data[index]["p_price"],
    style: TextStyle(fontSize: fontsize, fontFamily: semibold, color: redColor),
  );
}
