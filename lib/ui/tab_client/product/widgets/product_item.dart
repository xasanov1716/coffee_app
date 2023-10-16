import 'package:chandlier/data/models/coffee/coffee_model.dart';
import 'package:chandlier/ui/widgets/network_image.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ProductItem extends StatelessWidget {
  const ProductItem({Key? key, required this.coffeeModel}) : super(key: key);


  final CoffeeModel coffeeModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.c_273032),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ClipRRect(borderRadius: BorderRadius.circular(15),child: NetworkImageItem(image: coffeeModel.image,imageHeight: 111,imageWidth: 111,fit: BoxFit.cover,))
            ),
            SizedBox(height: 10 * height / figmaHeight),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .center,
              children: [
                Text(
                  coffeeModel.name,
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10 * height / figmaHeight),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(left: 18.w),
                    decoration: BoxDecoration(
                    color: Colors.green,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('₹${coffeeModel.price}', style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),),
                         const Spacer(),
                          Container(
                            padding: EdgeInsets.all(8.r),
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(12),
                               color: const Color(0xFFEFE3C8)
                             ),
                              child: const Icon(Icons.add))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
