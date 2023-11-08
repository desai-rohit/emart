import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/product_controller.dart';
import 'package:ecommerse_dev_app/views/pages/category_screen/categories_details.dart';
import 'package:ecommerse_dev_app/views/pages/category_screen/list/list.dart';
import 'package:ecommerse_dev_app/widget_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Category"),
        ),
        backgroundColor: lightGrey,
        body: Container(
          margin: const EdgeInsets.all(16),
          child: GridView.builder(
              itemCount: categoriesTitle.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 180),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    //controller.getSubCategories(categoriesTitle[index]);
                    Get.to(() => CategoriesDetails(
                          title: categoriesTitle[index],
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Image.asset(
                          categoriesImages[index],
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          categoriesTitle[index],
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 16, fontFamily: semibold),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
