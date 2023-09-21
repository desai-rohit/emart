import 'package:ecommerse_dev_app/consts/consts.dart';

Widget bgWidget({Scaffold? child}) {
  return Container(
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(imgBackground), fit: BoxFit.fill)),
    child: child,
  );
}
