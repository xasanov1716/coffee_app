import 'package:chandlier/bloc/category/category_bloc.dart';
import 'package:chandlier/bloc/category/category_event.dart';
import 'package:chandlier/bloc/checkout/checkout_bloc.dart';
import 'package:chandlier/data/local/storage/storage_repo.dart';
import 'package:chandlier/data/models/chekcout/checkout_model.dart';
import 'package:chandlier/data/models/order/order_model.dart';
import 'package:chandlier/main.dart';
import 'package:chandlier/provider/order_provider.dart';
import 'package:chandlier/ui/auth/widgets/global_button.dart';
import 'package:chandlier/ui/widgets/network_image.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:chandlier/utils/ui_utils/error_message_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  List<OrderModel>? order;

  String price = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C0F14),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF0C0F14),
        title: const Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<List<OrderModel>>(
                stream: context
                    .read<OrderProvider>()
                    .listenOrdersList(FirebaseAuth.instance.currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<List<OrderModel>> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? Column(
                          children: List.generate(
                            snapshot.data!.length,
                            (index) {
                              order = snapshot.data!;
                              OrderModel orderModel = snapshot.data![index];
                              price = orderModel.totalPrice.toString();
                              return ZoomTapAnimation(
                                onTap: () {
                                  context.read<OrderProvider>().deleteOrder(
                                      context: context,
                                      orderId: orderModel.orderId);
                                },
                                child: Slidable(
                                  endActionPane: ActionPane(motion: const StretchMotion(), children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        context.read<OrderProvider>().deleteOrder(context: context, orderId: orderModel.orderId);
                                        Navigator.pop(context);
                                      },
                                      borderRadius: BorderRadius.circular(15),
                                      backgroundColor: Colors.red,
                                      icon: Icons.delete,
                                      spacing: 10,
                                    ),
                                  ]),
                                  child: Container(
                                    padding: EdgeInsets.all(10.r),
                                    margin: EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15.r),
                                        color: AppColors.c_273032),
                                    child: ListTile(
                                      title: Text(orderModel.productName,style: TextStyle(color: AppColors.white),),
                                      leading: NetworkImageItem(
                                        image: orderModel.image,
                                        imageHeight: 111,
                                        imageWidth: 111,
                                        fit: BoxFit.cover,
                                      ),
                                      subtitle: Text(orderModel.count.toString(),style: TextStyle(color: AppColors.white),),
                                      trailing: Text(orderModel.totalPrice.toString(),style: TextStyle(color: AppColors.white),),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        : Center(
                            child: Lottie.asset('assets/lottie/empty.json'),
                          );
                  }
                  if (snapshot.hasError) {
                    return  Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              SizedBox(height: height * 100 / figmaHeight,),
               Divider(color: AppColors.white,),
              SizedBox(height: 10 * height / figmaHeight,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Full Name',style: TextStyle(color: AppColors.white,fontSize: 18.sp),),
                  Text(StorageRepository.getString('fullName'),style:  TextStyle(color: AppColors.white,fontSize: 18.sp),),
                ],
              ),
              SizedBox(height: 10 * height / figmaHeight,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Address',style: TextStyle(color: AppColors.white,fontSize: 18.sp),),
                  Text(StorageRepository.getString('address'),style:  TextStyle(color: AppColors.white,fontSize: 18.sp),),
                ],
              ),
              SizedBox(height: 10 * height / figmaHeight,),
              Divider(color: AppColors.white,),
              SizedBox(height: 10 * height / figmaHeight,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Grand Total',style: TextStyle(color: AppColors.white,fontSize: 24.sp),),

                  Text('₹$price',style:  TextStyle(color: AppColors.white,fontSize: 18.sp),),
                ],
              ),
              SizedBox(height: 20 * height / figmaHeight,),
              GlobalButton(
                  title: StorageRepository.getString('address').isNotEmpty? StorageRepository.getString('address').isNotEmpty?  'PAY NOW' : 'ADD INFO': 'ADD INFO',
                  onTap: () {
                    if(order != null && fullNameController.text.isNotEmpty && addressController.text.isNotEmpty){
                      context.read<CheckoutBloc>().add(AddCheckout(
                          checkoutModel: CheckoutModel(
                              fullName: fullNameController.text,
                              checkoutId: '',
                              address: addressController.text,
                              orders: [],
                              grandTotal: price)));
                      price = '0';
                      for(int i = 0;i < order!.length; i++){
                        context.read<OrderProvider>().deleteOrder(context: context, orderId: order![i].orderId);
                      }
                      setState(() {

                      });
                    }else{
                      showInfo(
                          address: addressController,
                          fullName: fullNameController,
                          onTap: () {
                            setState(() {

                            });
                            StorageRepository.putString('address', addressController.text);
                            StorageRepository.putString('fullName', fullNameController.text);
                            Navigator.pop(context);
                          },
                          context: context);
                    }
                  }),
              SizedBox(height: 24 * height / figmaHeight,)
            ],
          ),
        ),
      ),
    );
  }
}
