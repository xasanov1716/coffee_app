import 'package:chandlier/bloc/checkout/checkout_bloc.dart';
import 'package:chandlier/data/firebase/checkout_service.dart';
import 'package:chandlier/data/models/chekcout/checkout_model.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';



class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
        title: const Text('Order Screen'),
      ),
      body: StreamBuilder<List<CheckoutModel>>(
        stream: getIt.get<CheckOutService>().getCheckout(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CheckoutModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(
                snapshot.data!.length,
                    (index) {
                      CheckoutModel checkoutModel = snapshot.data![index];
                  return ZoomTapAnimation(
                    onTap: (){
                      context.read<CheckoutBloc>().add(DeleteCheckout(id: checkoutModel.checkoutId));
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
                          trailing: Text("₹${checkoutModel.grandTotal}"),
                          subtitle: Text(checkoutModel.address),
                          title: Text(checkoutModel.fullName),
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
