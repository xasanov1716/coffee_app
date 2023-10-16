import 'package:chandlier/data/models/order/order_model.dart';
import 'package:chandlier/provider/order_provider.dart';
import 'package:chandlier/ui/widgets/network_image.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: context
            .read<OrderProvider>()
            .listenOrdersList(FirebaseAuth.instance.currentUser!.uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      children: List.generate(
                        snapshot.data!.length,
                        (index) {
                          OrderModel orderModel = snapshot.data![index];
                          return ZoomTapAnimation(
                            onTap: () {
                              context.read<OrderProvider>().deleteOrder(
                                  context: context,
                                  orderId: orderModel.orderId);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.r),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.r),
                                  color: AppColors.c_273032),
                              child: ListTile(
                                title: Text(orderModel.productName),
                                leading: NetworkImageItem(
                                  image: orderModel.image,
                                  imageHeight: 111,
                                  imageWidth: 111 ,
                                  fit: BoxFit.cover,
                                ),
                                subtitle: Text(orderModel.userId.toString()),
                                trailing:
                                    Text(orderModel.totalPrice.toString()),
                              ),
                            ),
                          );
                        },
                      ),
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
    );
  }
}
