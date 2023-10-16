import 'package:chandlier/data/models/coffee/coffee_model.dart';
import 'package:chandlier/data/models/order/order_model.dart';
import 'package:chandlier/provider/order_provider.dart';
import 'package:chandlier/ui/auth/widgets/global_button.dart';
import 'package:chandlier/ui/widgets/network_image.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {super.key, required this.coffeeModel});

  final CoffeeModel coffeeModel;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int count = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
        title: Text(
          "Product Detail",
          style: TextStyle(
              fontSize: 20.spMin,
              color: Colors.white,
              fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(18.r),
        child: Column(
          children: [
            Expanded(
              child: ListView(

                physics: const BouncingScrollPhysics(),
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25.r),
                    child: NetworkImageItem(image: widget.coffeeModel.image,imageHeight: 411,imageWidth: 343,fit: BoxFit.cover,)
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    widget.coffeeModel.name,
                    style: TextStyle(
                        fontSize: 32.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    widget.coffeeModel.description,
                    style: TextStyle(
                        fontSize: 22.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Price: ₹${widget.coffeeModel.price}",
                    style: TextStyle(
                        fontSize: 22.spMin,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (count > 1) {
                            setState(() {
                              count--;
                            });
                          }
                        },
                        child: const Icon(
                          Icons.remove,
                        ),
                      ),
                      Text(
                        count.toString(),
                        style:  TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                              setState(() {
                                count++;
                              });

                          },
                          child: const Icon(Icons.add)),
                    ],
                  ),

                  Text(
                    "Total price: ₹${int.parse(widget.coffeeModel.price) * count}",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: height * 34 / figmaHeight,),
                ],
              ),
            ),
            SizedBox(height: height * 24 / figmaHeight,),
            GlobalButton(
              onTap: () {
                debugPrint('IMAGE :${widget.coffeeModel.image}');
                Provider.of<OrderProvider>(context, listen: false).addOrder(
                  context: context,
                  orderModel: OrderModel(
                    image: widget.coffeeModel.image,
                    count: count,
                    totalPrice: int.parse(widget.coffeeModel.price) * count,
                    orderId: "",
                    productId: widget.coffeeModel.coffeeId,
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    orderStatus: "ordered",
                    createdAt: DateTime.now().toString(),
                    productName: widget.coffeeModel.name,
                  ),
                );
              },
              title: "Add to Card",
            ),
            SizedBox(height: 24 * height / figmaHeight,)
          ],
        ),
      ),
    );
  }
}
