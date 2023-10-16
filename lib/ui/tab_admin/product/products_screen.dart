
import 'package:chandlier/bloc/product/product_bloc.dart';
import 'package:chandlier/bloc/product/product_event.dart';
import 'package:chandlier/data/firebase/product_service.dart';
import 'package:chandlier/data/models/coffee/coffee_model.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:chandlier/ui/tab_admin/product/subscreen/add_product.dart';
import 'package:chandlier/ui/tab_admin/product/subscreen/update_product_screen.dart';
import 'package:chandlier/ui/widgets/network_image.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class ProductScreenAdmin extends StatefulWidget {
  const ProductScreenAdmin({super.key});

  @override
  State<ProductScreenAdmin> createState() => _ProductScreenAdminState();
}

class _ProductScreenAdminState extends State<ProductScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
        title: const Text("Products Admin"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AddProductScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: StreamBuilder<List<CoffeeModel>>(
          stream: getIt.get<ProductsService>().getProducts(''),
          builder:
              (BuildContext context, AsyncSnapshot<List<CoffeeModel>> snapshot) {
            if (snapshot.hasData) {
              return snapshot.data!.isNotEmpty
                  ?  GridView(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2,
                  crossAxisSpacing: 10.w,mainAxisSpacing: 10.h,
                ),
                children: List.generate(
                  snapshot.data!.length,
                      (index) {
                        CoffeeModel productModel = snapshot.data![index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.w,vertical: 15.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.blue.withOpacity(0.8)
                      ),
                      child: ListTile(
                        leading: NetworkImageItem(image: productModel.image, imageHeight: 111, imageWidth: 111),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.white,
                              content:const Padding(
                                padding:  EdgeInsets.only(top: 10),
                                child: Text(
                                  "Delete Product",
                                  style:
                                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                                ),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () {
                                    context.read<ProductBloc>().add(DeleteProductEvent(id: productModel.coffeeId));
                                    Navigator.of(context).pop();
                                  },
                                  isDefaultAction: true,
                                  child: const Text("ok"),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  isDefaultAction: true,
                                  child: const Text("cancel"),
                                ),

                              ],
                            ),
                          );
                        },
                        title: Text(productModel.name,style: TextStyle(fontSize: 24.spMin,color: Colors.white,fontWeight: FontWeight.w700),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(productModel.description,style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                            Text("Price: ${productModel.price}",style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                            Text("Count: ${productModel.description}",style: TextStyle(fontSize: 18.spMin,color: Colors.white,fontWeight: FontWeight.w500),),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return   UpdateProduct(coffeeModel: productModel);
                                },
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit,color: Colors.white,),
                        ),
                      ),
                    );
                  },
                ),
              )
                  :  Center(child: Text("Product Empty!",style: TextStyle(fontSize: 32.sp,color: Colors.white,fontWeight: FontWeight.w700),));
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}