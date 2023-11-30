import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerse_dev_app/consts/consts.dart';
import 'package:ecommerse_dev_app/controller/home_controller.dart';
import 'package:ecommerse_dev_app/services/firestore_services.dart';
import 'package:ecommerse_dev_app/views/pages/cart_page/cart_page.dart';
import 'package:ecommerse_dev_app/views/pages/category_screen/category_screen.dart';
import 'package:ecommerse_dev_app/views/pages/home_screen/home_page.dart';
import 'package:ecommerse_dev_app/views/pages/no_internet/no_internet.dart';
import 'package:ecommerse_dev_app/views/pages/no_internet/provider_internet.dart';
import 'package:ecommerse_dev_app/views/pages/profile_page/profile_page.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  String? docId;
  Home({super.key, this.docId});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {

 var controller = Get.put(ProviderInternet()); 

 controller.startMonitoring();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // init home controller

    var controller = Get.put(HomeController());
     var providerinternet = Get.put(ProviderInternet()); 
     print(providerinternet.isOnline.value);
    var navbarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(
            icHome,
            width: 26,
          ),
          label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icCategories,
            width: 26,
          ),
          label: "Category"),
      BottomNavigationBarItem(
          icon: StreamBuilder(
            stream: FirestoreServices.getcartproduct(currentUser!.uid),
            builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                var data = snapshot.data!.docs;
                // Map<String, dynamic> data =
                //     snapshot.data!.data() as Map<String, dynamic>;

                return Stack(children: [
                  Image.asset(
                    icCart,
                    width: 26,
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: redColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Text(
                        data.length.toString(),
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ),
                ]);
              }
            }),
          ),
          label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProfile,
            width: 26,
          ),
          label: "Account"),
    ];

    List<Widget> navbody = [
      const HomePage(),
      const CategoryPage(),
      const CartPage(),
      const ProfilePage(),
    ];
    return Obx(()=>
     providerinternet.isOnline.value? Scaffold(
          body: Column(
            children: [
              // Obx(
              //   () => Expanded(
              //       child: navbody.elementAt(controller.currentNavIndex.value)),
              // ),
              Expanded(
                  child:IndexedStack(
                    index: controller.currentNavIndex.value,
                    children: navbody,
                  )
                ),
              
            ],
          ),
          bottomNavigationBar:  BottomNavigationBar(
                  currentIndex: controller.currentNavIndex.value,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: whiteColor,
                  selectedItemColor: redColor,
                  selectedLabelStyle: const TextStyle(fontFamily: semibold),
                  items: navbarItem,
                  onTap: (value) {
                    controller.currentNavIndex.value = value;
                  },
                )
          
          ):const NoInternet(),
    );
  }
}
