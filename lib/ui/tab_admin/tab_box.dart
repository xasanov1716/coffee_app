import 'package:chandlier/ui/tab_admin/categories/category_screen.dart';
import 'package:chandlier/ui/tab_admin/order/order_screen.dart';
import 'package:chandlier/ui/tab_admin/product/products_screen.dart';
import 'package:chandlier/ui/tab_admin/profile/profile_screen.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TabBoxAdmin extends StatefulWidget {
  const TabBoxAdmin({super.key});

  @override
  State<TabBoxAdmin> createState() => _TabBoxAdminState();
}

class _TabBoxAdminState extends State<TabBoxAdmin> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
      const ProductScreenAdmin(),
      const CategoryScreenAdmin(),
      const OrderScreen(),
      const ProfileScreenAdmin(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentIndex,children: screens,),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: AppColors.c_0C1A30,
        buttonBackgroundColor: AppColors.c_273032,
        height: 75,
        items: const <Widget>[
          Icon(Icons.device_hub, size: 30, color: Colors.white),
          Icon(Icons.category_outlined, size: 30, color: Colors.white),
          Icon(Icons.bookmark_border, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
