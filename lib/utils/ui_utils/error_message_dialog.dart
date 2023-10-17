import 'package:chandlier/ui/auth/widgets/global_button.dart';
import 'package:chandlier/ui/auth/widgets/global_text_fields.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:chandlier/utils/size/size_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../size/screen_size.dart';


void showErrorMessage({
  required String message,
  required BuildContext context,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: const Color(0xFFEDE0D4),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/error.json'),
              30.ph,
              Text('ERROR!',
                  style: Theme.of(context).dialogTheme.titleTextStyle),
              16.ph,
              Center(
                child: Text(
                  message,
                  style: TextStyle(fontSize: 14.sp,color:  AppColors.c_0C1A30),
                  textAlign: TextAlign.center,
                ),
              ),
              16.ph,

              SizedBox(
                height: 78 * height / figmaHeight,
                child: GlobalButton(
                  title: 'OK',
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}


void showInfo({
  required TextEditingController address,
  required TextEditingController  fullName,
  required VoidCallback onTap,
  required BuildContext context,
}) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          backgroundColor: const Color(0xFFEDE0D4),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlobalTextField(hintText: 'FullName',controller: fullName,keyboardType: TextInputType.text,textInputAction: TextInputAction.next),
              SizedBox(height: 24 * height / figmaHeight,),
              GlobalTextField(hintText: 'Address',controller: address,keyboardType: TextInputType.text,textInputAction: TextInputAction.done),
              SizedBox(height: 24 * height / figmaHeight,),
              GlobalButton(title: 'Add Info', onTap: onTap)
            ],
          ),
        );
      },
    ),
  );
}