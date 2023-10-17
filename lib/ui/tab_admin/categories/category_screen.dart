import 'package:chandlier/bloc/category/category_bloc.dart';
import 'package:chandlier/bloc/category/category_event.dart';
import 'package:chandlier/data/firebase/category_service.dart';
import 'package:chandlier/data/models/category/category_model.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:chandlier/ui/tab_admin/categories/add_category.dart';
import 'package:chandlier/ui/tab_admin/categories/update_category.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/colors/app_colors.dart';

class CategoryScreenAdmin extends StatefulWidget {
  const CategoryScreenAdmin({super.key});

  @override
  State<CategoryScreenAdmin> createState() => _CategoryScreenAdminState();
}
class _CategoryScreenAdminState extends State<CategoryScreenAdmin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
        title: const Text("Categories"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddCategoryScreen()));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: getIt.get<CategoryService>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
                    children: List.generate(
                      snapshot.data!.length,
                      (index) {
                        CategoryModel categoryModel = snapshot.data![index];
                        return GestureDetector(
                          onTap: (){
                            context.read<CategoryBloc>().add(DeleteCategoryEvent(id: categoryModel.categoryId));
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateCategoryScreen(categoryModel: categoryModel)));
                          },
                          onLongPress: (){
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateCategoryScreen(categoryModel: categoryModel)));
                          },
                          child: Container(
                            margin: EdgeInsets.all(10.r),
                            padding: EdgeInsets.all(5.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(categoryModel.categoryName),
                            )
                          ),
                        );
                      },
                    ),
                  )
                : Center(child: Lottie.asset('assets/lottie/empty.json'),);
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}