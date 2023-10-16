import 'package:chandlier/data/firebase/category_service.dart';
import 'package:chandlier/data/firebase/product_service.dart';
import 'package:chandlier/data/models/category/category_model.dart';
import 'package:chandlier/data/models/coffee/coffee_model.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:chandlier/ui/tab_client/product/product_detail_screen.dart';
import 'package:chandlier/ui/tab_client/product/widgets/product_item.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:chandlier/utils/images/app_images.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import 'widgets/category_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedCategoryId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0F14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0C0F14),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.search,
                color: AppColors.white,
              )),
          SizedBox(width: 20 * height / figmaHeight)
        ],
        leading: Padding(
          padding: const EdgeInsets.all(14),
          child: SvgPicture.asset(AppImages.more, height: 12 * height / figmaHeight, width: 32 * figmaWidth / figmaWidth),
        ),
      ),
      body: Column(
        children: [
          StreamBuilder<List<CategoryModel>>(
            stream: getIt.get<CategoryService>().getCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CategoryModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? SizedBox(
                        height: 50 * height / figmaHeight,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryItemView(
                              categoryModel: CategoryModel(
                                categoryId: "",
                                categoryName: "All",
                                createdAt: "",
                              ),
                              onTap: () {
                                setState(() {
                                  selectedCategoryId = "";
                                });
                              },
                              selectedId: selectedCategoryId,
                            ),
                            ...List.generate(
                              snapshot.data!.length, (index) {
                                CategoryModel categoryModel =snapshot.data![index];
                                return CategoryItemView(
                                  categoryModel: categoryModel,
                                  onTap: () {
                                    setState(() {
                                      selectedCategoryId = categoryModel.categoryId;
                                    });
                                  },
                                  selectedId: selectedCategoryId,
                                );
                              },
                            )
                          ],
                        ),
                      )
                    : const Center(child: Text("Empty!"));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          StreamBuilder<List<CoffeeModel>>(
            stream: getIt.get<ProductsService>().getProducts(''),
            builder: (BuildContext context,
                AsyncSnapshot<List<CoffeeModel>> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!.isNotEmpty
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: StreamBuilder<List<CoffeeModel>>(
                            stream: getIt.get<ProductsService>().getProducts(selectedCategoryId),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<CoffeeModel>> snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.isNotEmpty
                                    ? GridView(gridDelegate:
                                             SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                                childAspectRatio: 0.6.r),
                                        children: [
                                          ...List.generate(snapshot.data!.length, (index) {
                                            CoffeeModel productModel = snapshot.data![index];
                                            return ZoomTapAnimation(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => ProductDetailScreen(coffeeModel: productModel)));
                                              },
                                              child: ProductItem(coffeeModel: productModel,)
                                            );
                                          })
                                        ],
                                      )
                                    :  Center(
                                        child: Lottie.asset('assets/lottie/empty.json')
                                      );
                              }
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      )
                    : const Center(child: Text("Product Empty!"));
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
