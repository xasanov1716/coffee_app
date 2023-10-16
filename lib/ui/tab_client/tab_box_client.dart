import 'package:chandlier/ui/tab_client/cart/cart_screen.dart';
import 'package:chandlier/ui/tab_client/product/product_screen.dart';
import 'package:chandlier/ui/tab_client/profile/profile_screen.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class TabBoxClient extends StatefulWidget {
  const TabBoxClient({super.key});

  @override
  State<TabBoxClient> createState() => _TabBoxClientState();
}

class _TabBoxClientState extends State<TabBoxClient> {
  List<Widget> screens = [];

  int currentIndex = 0;

  @override
  void initState() {
    screens = [
     const ProductsScreen(),
     const CartScreen(),
      const ProfileScreenClient(),
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
          Icon(Icons.shopping_basket, size: 30, color: Colors.white),
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
